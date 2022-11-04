require 'rails_helper'

RSpec.describe 'plots#show' do
  describe 'GET api/v1/gardens/:garden_id/plots/:plot_id' do
    it 'returns a json response with information about the requested plot' do
      garden = create :garden
      plot = create(:plot, garden: garden)
      plants = create_list(:plant, 5)
      plot_plant_1 = PlotPlant.create!(plot: plot, plant: plants[0], quantity: 1, date_planted: DateTime.now)
      plot_plant_2 = PlotPlant.create!(plot: plot, plant: plants[1], quantity: 1, date_planted: DateTime.now)
      plot_plant_3 = PlotPlant.create!(plot: plot, plant: plants[2], quantity: 1, date_planted: DateTime.now)
      plot_plant_4 = PlotPlant.create!(plot: plot, plant: plants[3], quantity: 1, date_planted: DateTime.now)
      plot_plant_5 = PlotPlant.create!(plot: plot, plant: plants[4], quantity: 1, date_planted: DateTime.now)
      plot.reload
      
      get "/api/v1/gardens/#{garden.id}/plots/#{plot.id}"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to have_key(:data)

      data = result[:data]
      expect(data).to have_key(:id)
      expect(data).to have_key(:type)
      expect(data).to have_key(:attributes)
      expect(data).to have_key(:relationships)
      
      attributes = data[:attributes]
      expect(attributes).to have_key(:name)
      expect(attributes).to have_key(:soil_ph_min)
      expect(attributes[:soil_ph_min]).to eq(plot.soil_ph_min.to_s)
      expect(attributes).to have_key(:soil_ph_max)
      expect(attributes[:soil_ph_max]).to eq(plot.soil_ph_max.to_s)
      expect(attributes).to have_key(:shade_tolerant?)
      expect(attributes[:shade_tolerant?]).to eq(plot.shade_tolerant?)
      expect(attributes).to have_key(:contains_toxic?)
      expect(attributes[:contains_toxic?]).to eq(plot.contains_toxic?)

      expect(data[:relationships]).to have_key(:plants)

      plants = data[:relationships][:plants]
      expect(plants).to have_key(:data)
    end

    it 'relevant attributes return nil if no plants are added' do
      garden = create :garden
      plot = create(:plot, garden: garden)

      get "/api/v1/gardens/#{garden.id}/plots/#{plot.id}"

      result = JSON.parse(response.body, symbolize_names: true)
      attributes = result[:data][:attributes]
      expect(attributes[:soil_ph_min]).to eq(nil)
      expect(attributes[:soil_ph_max]).to eq(nil)
      expect(attributes[:shade_tolerant?]).to eq(nil)
      expect(attributes[:contains_toxic?]).to eq(nil)
    end
  end
end