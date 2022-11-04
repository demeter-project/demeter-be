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
end
# expected http request JSON body:

# {
#   "date_planted": 2022-5-13,
#   "quantity": 15
# }
# should return a 200 status and the plot_plant object JSON:

# {
#   "data": {
#     "id": "15",
#     "type": "plot plant",
#     "attributes": {
#       "quantity": 15,
#       "date_planted": 2022-5-15,
#       "plant_id": 85,
#       "plant_name": "Wild Thornbush"
#     }
#   }
# }