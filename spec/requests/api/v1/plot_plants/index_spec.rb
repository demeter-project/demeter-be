require 'rails_helper'

RSpec.describe 'get /gardens/:garden_id/plots/:plot_id/plot_plants' do
  describe 'When the record exists' do
    it 'returns a list of plot_plants within the plot' do
      garden = create(:garden)
      plot_1 = create(:plot, garden: garden)
      plot_2 = create(:plot, garden: garden)

      plant_1 = create(:plant)
      plant_2 = create(:plant)

      plot_plant_1 = PlotPlant.create!(plot: plot_1, plant_id: plant_1.id, quantity: 4)
      plot_plant_2 = PlotPlant.create!(plot: plot_1, plant: plant_2, quantity: 4)

      plot_plant = PlotPlant.create!(plot: plot_2, plant: plant_2, quantity: 4)

      get "/api/v1/gardens/#{garden.id}/plots/#{plot_1.id}/plot_plants"
      plot_plant_1.reload

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      results = JSON.parse(response.body, symbolize_names: true)
      result = results[:data].first

      expect(result).to be_a(Hash)
      expect(result).to have_key(:id)
      expect(result).to have_key(:type)
      expect(result).to have_key(:attributes)
      expect(result[:attributes]).to be_a(Hash)
      expect(result[:attributes]).to have_key(:plant_id)
      expect(result[:attributes][:plant_id]).to be_a(String)
      expect(result[:attributes]).to have_key(:plant_name)
      expect(result[:attributes][:plant_name]).to be_a(String)

      expect(result[:attributes]).to have_key(:quantity)
      expect(result[:attributes][:quantity]).to be_a(Integer)
      expect(result[:attributes]).to have_key(:date_planted)
      expect(result[:attributes][:date_planted]).to be_a(String)
    end
  end
end

# Returns a list of "plot_plants" within the plot. Also includes the name attribute from the associated plant.

# {
#   "data": [
#     {
#       "id": "3",
#       "type": "plot_plant",
#       "attributes": {
#         "plant_id": "15"
#         "plant_name": "Common Clover"
#         "quantity": 5
#         "date_planted": 2022/05/18
#       }
#     },
#     {
#       "id": "4",
#       "type": "plot_plant",
#       "attributes": {
#         "plant_id": "185"
#         "plant_name": "Columbine"
#         "quantity": 18
#         "date_planted": 2022/05/17
#       }
#     },
#     **etc...**
#   ]
# }

# get /gardens/:garden_id/plots/:plot_id/plot_plants