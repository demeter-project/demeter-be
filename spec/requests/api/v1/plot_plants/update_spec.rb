require 'rails_helper'

RSpec.describe 'patch /gardens/:garden_id/plots/:plot_id/plot_plant/:id' do
  describe 'When the record exists' do
    describe "updating a plot plant when it is being 'planted'" do
      it 'updates the quantity and date planted attributes' do
        garden = create(:garden)
        plot_1 = create(:plot, garden: garden)

        plant_1 = create(:plant)
        plant_2 = create(:plant)

        plot_plant_1 = PlotPlant.create!(plot: plot_1, plant_id: plant_1.id)
        plot_plant_2 = PlotPlant.create!(plot: plot_1, plant: plant_2)

        previous_date = {date_planted: plot_plant_1.date_planted}
        previous_quantity = {quantity: plot_plant_1.quantity}
        params = {
            date_planted: DateTime.now,
            quantity: 15
          }
        headers = {"CONTENT_TYPE" => "application/json"}

        patch "/api/v1/gardens/#{garden.id}/plots/#{plot_1.id}/plot_plants/#{plot_plant_1.id}", headers: headers, params: JSON.generate({plot_plant: params})
        plot_plant = PlotPlant.find(plot_plant_1.id)

        expect(response).to be_successful
        expect(response).to have_http_status(200)
        expect(plot_plant.date_planted).to_not eq(previous_date)
        expect(plot_plant.quantity).to_not eq(previous_quantity)
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:data][:attributes][:quantity]).to eq(params[:quantity])
        expect(result[:data][:attributes][:date_planted]).to eq(params[:date_planted].strftime("%Y/%m/%d"))
      end
    end
  end

  describe 'When the record does not exist' do
    it 'returns a status 404' do
      
      params = {
        date_planted: DateTime.now,
          quantity: 15
        }
      headers = {"CONTENT_TYPE" => "application/json"}
        
      patch "/api/v1/gardens/1/plots/1/plot_plants/1", headers: headers, params: JSON.generate({plot_plant: params})

      expect(response).to have_http_status(404)
    end

    it 'returns a not found message' do
      params = {
        date_planted: DateTime.now,
          quantity: 15
        }
      headers = {"CONTENT_TYPE" => "application/json"}
        
      patch "/api/v1/gardens/1/plots/1/plot_plants/1", headers: headers, params: JSON.generate({plot_plant: params})

      expect(response.body).to match(/Couldn't find PlotPlant/)
    end
  end
end