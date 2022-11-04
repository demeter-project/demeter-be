# patch /gardens/:garden_id/plots/:plot_id/plot_plant/:id

# This endpoint can receive a patch request for a plot_plant to update it with the date_planted and quantity attributes when its being "planted"

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
require 'rails_helper'

RSpec.describe 'patch /gardens/:garden_id/plots/:plot_id/plot_plant/:id' do
  describe "updating a plot plant when it is being 'planted'" do
    it 'updates the quantity and date planted attributes' do
      garden = create(:garden)
      plot_1 = create(:plot, garden: garden)
      plot_2 = create(:plot, garden: garden)

      plant_1 = create(:plant)
      plant_2 = create(:plant)

      plot_plant_1 = PlotPlant.create!(plot: plot_1, plant_id: plant_1.id, quantity: 4)
      plot_plant_2 = PlotPlant.create!(plot: plot_1, plant: plant_2, quantity: 4)

      patch "/gardens/#{garden.id}/plots/#{plot.id}/plot_plant/#{plot_plant.id}"



    end
  end
end