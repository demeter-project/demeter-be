require 'rails_helper'

RSpec.describe Plot, type: :model do
  describe 'relationships' do
    it { should belong_to :garden }
    it { should have_many :plot_plants }
    it { should have_many(:plants).through(:plot_plants)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'instance methods' do
    let!(:garden) { create :garden }
    let!(:plot) { create :plot, garden: garden }

    describe 'ph averages' do
      let!(:plant_1) { create(:plant, ph_minimum: 4, ph_maximum: 6) }
      let!(:plant_2) { create(:plant, ph_minimum: 4.5, ph_maximum: 6.5) }
      let!(:plant_3) { create(:plant, ph_minimum: 5, ph_maximum: 7) }
      let!(:plants) { [plant_1, plant_2, plant_3] }

      it 'returns nil if plot has no plants' do
        expect(plot.soil_ph_min).to eq(nil)
        expect(plot.soil_ph_max).to eq(nil)
      end

      it 'returns the average of all plants ph_minimum' do
        plot.plants << plants
        expect(plot.soil_ph_min).to eq(5)
        expect(plot.soil_ph_max).to eq(6)
      end

      describe '#shade_tolerant' do
        it 'returns nil if plot has no plants' do
          expect(plot.shade_tolerant?).to eq(nil)
        end
        
        it 'returns a boolean true if all plants are shade tolerant' do
          plant_1 = create(:plant, shade_tolerance: "Tolerant")
          plant_2 = create(:plant, shade_tolerance: "Tolerant")
          plant_3 = create(:plant, shade_tolerance: "Tolerant")
          plants = [plant_1, plant_2, plant_3]
          plot.plants << plants
          expect(plot.shade_tolerant?).to eq(true)
        end

        it 'returns a boolean false if any plants are not shade tolerant' do
          plant_1 = create(:plant, shade_tolerance: "Tolerant")
          plant_2 = create(:plant, shade_tolerance: "Intermediate")
          plant_3 = create(:plant, shade_tolerance: "Intolerant")
          plants = [plant_1, plant_2, plant_3]
          plot.plants << plants
          expect(plot.shade_tolerant?).to eq(false)
        end
      end

      describe '#contains_toxic?' do
        it 'returns nil if plot has no plants' do
          expect(plot.contains_toxic?).to eq(nil)
        end

        it 'returns boolean true if any plants are toxic' do
          plant_1 = create(:plant, toxicity: "None")
          plant_2 = create(:plant, toxicity: "Slight")
          plant_3 = create(:plant, toxicity: "Severe")
          plants = [plant_1, plant_2, plant_3]
          plot.plants << plants
          expect(plot.contains_toxic?).to eq(true)
        end

        it 'returns boolean false if no plants are toxic' do
          plant_1 = create(:plant, toxicity: "None")
          plant_2 = create(:plant, toxicity: "None")
          plant_3 = create(:plant, toxicity: "None")
          plants = [plant_1, plant_2, plant_3]
          plot.plants << plants
          expect(plot.contains_toxic?).to eq(false)
        end
      end
    end
  end
end
