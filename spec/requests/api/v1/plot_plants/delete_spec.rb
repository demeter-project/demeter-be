require 'rails_helper'

RSpec.describe 'delete /gardens/:garden_id/plots/:plot_id/plot_plant/:id', :vcr do
  describe 'delete a plant from a garden' do
    it 'deletes the plot plant record from the table' do
      garden = create(:garden)
      plot_1 = create(:plot, garden: garden)
      plot_2 = create(:plot, garden: garden)

      plant_1 = create(:plant)
      plant_2 = create(:plant)

      plot_plant_1 = PlotPlant.create!(plot: plot_1, plant_id: plant_1.id, quantity: 4, date_planted: DateTime.now - 1.day)
      plot_plant_2 = PlotPlant.create!(plot: plot_1, plant: plant_2, quantity: 4, date_planted: DateTime.now - 1.day)

      delete "/api/v1/gardens/#{garden.id}/plots/#{plot_1.id}/plot_plants/#{plot_plant_1.id}"

      expect(response).to be_successful
      expect(response).to have_http_status(204)
      expect(response.body).to be_empty
      expect{PlotPlant.find(plot_plant_1.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(PlotPlant.find(plot_plant_2.id)).to eq(plot_plant_2)
    end
  end
end