require 'rails_helper'

RSpec.describe Plant, type: :model do
  
  describe 'relationships' do
    it { should have_many(:plot_plants) }
    it { should have_many(:plots).through(:plot_plants) }
  end

  describe 'class methods' do
    describe '#native_to(state)' do
      it 'returns all plants native to provided state' do
        plant_1 = create(:plant, states: "VT VA")
        plant_2 = create(:plant, states: "VT WA")
        plant_3 = create(:plant, states: "VA WA")

        expect(Plant.native_to("VT")).to include(plant_1, plant_2)
        expect(Plant.native_to("VT")).not_to include(plant_3)
      end
    end
  end

  describe 'instance methods' do
    describe '#search_name(name)' do
      it 'returns any plants matching a fragment of common name' do
        plant_1 = create(:plant, common_name: "Halo Bunny", states: "VT WA")
        plant_2 = create(:plant, common_name: "Hal Bunno", states: "VT WA")
        plant_3 = create(:plant, common_name: "Squirrel", states: "VT WA")

        expect(Plant.search_name("hal", "VT")).to include(plant_1, plant_2)
        expect(Plant.search_name("hal", "VT")).not_to include(plant_3)
      end

      it 'also searches scientific name' do
        plant_1 = create(:plant, common_name: "Halo Bunny", states: "VT WA")
        plant_2 = create(:plant, scientific_name: "Hal Bunno", states: "VT WA")
        plant_3 = create(:plant, common_name: "Squirrel", scientific_name: "Gary", states: "VT WA")

        expect(Plant.search_name("hal", "VT")).to include(plant_1, plant_2)
        expect(Plant.search_name("hal", "VT")).not_to include(plant_3)
      end
    end
  end
end
