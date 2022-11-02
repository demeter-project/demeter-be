require 'rails_helper'

RSpec.describe 'plots#show' do
  describe 'GET api/v1/gardens/:garden_id/plots/:plot_id' do
    it 'returns a json response with information about the requested plot' do
      garden = create :garden
      plot = create(:plot, garden: garden)
      plot.plants = create_list(:plant, 10)

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
      expect(attributes).to have_key(:shade_tolerant)
      expect(attributes[:shade_tolerant]).to eq(plot.shade_tolerant)

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
      expect(attributes[:shade_tolerant]).to eq(nil)
    end
  end
end