require 'rails_helper'

RSpec.describe Plant, type: :model do
  
  describe 'relationships' do

  end

  describe 'validations' do
    it { should validate_presence_of(:symbol) }
    it { should validate_presence_of(:scientific_name) }
    it { should validate_presence_of(:common_name) }
    it { should validate_presence_of(:temperature_min) }
    it { should validate_presence_of(:moisture_use) }

    it { should validate_numericality_of(:temperature_min) }
  end

  describe 'class methods' do
    describe '#native_to(state)' do
      it 'returns all plants native to provided state' do
        plant_1 = create(:plant, native_states: "VT VA")
        plant_2 = create(:plant, native_states: "VT WA")
        plant_3 = create(:plant, native_states: "VA WA")

        expect(Plant.native_to("VT")).to include(plant_1, plant_2)
        expect(Plant.native_to("VT")).not_to include(plant_3)
      end
    end
  end
end
