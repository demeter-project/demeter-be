require 'rails_helper'

RSpec.describe PlotPlant, type: :model do
  describe 'relationships' do
    it { should belong_to :plot }
    it { should belong_to :plant }
  end

  describe 'validations' do
    it { should validate_presence_of :plot_id }
    it { should validate_presence_of :plant_id }
  end

  describe 'class methods' do
    describe 'find plot plants' do
      it 'returns all plot plants with a matching plot id' do
        garden = create(:garden)
        plot_1 = create(:plot, garden: garden)
        plot_2 = create(:plot, garden: garden)

        plant_1 = create(:plant)
        plant_2 = create(:plant)

        plot_plant_1 = PlotPlant.create!(plot: plot_1, plant_id: plant_1.id, quantity: 4)
        plot_plant_2 = PlotPlant.create!(plot: plot_1, plant: plant_2, quantity: 4)
        plot_plant_3 = PlotPlant.create!(plot: plot_2, plant: plant_2, quantity: 4)

        expect(PlotPlant.find_plot_plants(plot_1.id)).to eq([plot_plant_1, plot_plant_2])
      end
    end
  end
end
