require 'rails_helper'

RSpec.describe 'plot destroy' do
  let!(:garden) { create :garden }
  let!(:plot) { create :plot, garden: garden }
  let!(:plants) { create_list(:plant, 3) }

  describe 'DELETE /gardens/:garden_id/plots/:id' do
    it 'deletes the relevant plot' do
      delete "/api/v1/gardens/#{garden.id}/plots/#{plot.id}"

      expect(response).to be_successful
      expect(response).to have_http_status(204)
      expect(response.body).to be_empty
    end

    it 'deletes any plot_plants in plot' do
      plot_plant_1 = PlotPlant.create!(plot: plot, plant: plants[0], quantity: 1, date_planted: DateTime.now)
      plot_plant_1 = PlotPlant.create!(plot: plot, plant: plants[1], quantity: 1, date_planted: DateTime.now)
      plot_plant_1 = PlotPlant.create!(plot: plot, plant: plants[2], quantity: 1, date_planted: DateTime.now)

      delete "/api/v1/gardens/#{garden.id}/plots/#{plot.id}"

      expect(response).to be_successful
      expect(response).to have_http_status(204)
      expect(response.body).to be_empty
    end
  end
end