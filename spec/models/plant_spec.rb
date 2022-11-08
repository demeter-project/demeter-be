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
        expect(Plant.native_to("NA")).to eq([])
      end
    end

    describe '#search_name(name)' do
      it 'returns any plants matching a fragment of common name' do
        plant_1 = create(:plant, common_name: "Halo Bunny", states: "VT WA")
        plant_2 = create(:plant, common_name: "Hal Bunno", states: "VT WA")
        plant_3 = create(:plant, common_name: "Squirrel", states: "VT WA")
        plant_4 = create(:plant, common_name: "Squirrel", states: "VA WA")

        plants = Plant.native_to("VT")

        expect(plants.search_name("hal")).to include(plant_1, plant_2)
        expect(plants.search_name("hal")).not_to include(plant_3, plant_4)
      end

      it 'also searches scientific name' do
        plant_1 = create(:plant, common_name: "Halo Bunny", states: "VT WA")
        plant_2 = create(:plant, scientific_name: "Hal Bunno", states: "VT WA")
        plant_3 = create(:plant, common_name: "Squirrel", scientific_name: "Gary", states: "VT WA")
        plant_4 = create(:plant, common_name: "Squirrel", states: "VA WA")

        plants = Plant.native_to("VT")

        expect(plants.search_name("hal")).to include(plant_1, plant_2)
        expect(plants.search_name("hal")).not_to include(plant_3)
      end

      it 'returns an empty array if no name matches' do
        plant_1 = create(:plant, common_name: "Halo Bunny", states: "VT WA")
        plant_2 = create(:plant, scientific_name: "Hal Bunno", states: "VT WA")
        plant_3 = create(:plant, common_name: "Squirrel", scientific_name: "Gary", states: "VT WA")
        plant_4 = create(:plant, common_name: "Squirrel", states: "VA WA")

        plants = Plant.native_to("VT")

        expect(plants.search_name('1$#')).to eq([])
      end
    end
  
    describe '::sort_by(attribute)' do
      let!(:plant_1) { create :plant, common_name: "Dogfern", scientific_name: "A", temperature_min: 15, states: "VT VA CA" }
      let!(:plant_2) { create :plant, common_name: "Aardvarkleaf", scientific_name: "B", temperature_min: 10, states: "VT VA CA" }
      let!(:plant_3) { create :plant, common_name: "Bearwood", scientific_name: "C", temperature_min: 5, states: "VT VA CA" }
      let!(:plant_4) { create :plant, common_name: "Bearwood", scientific_name: "D", temperature_min: 5, states: "VA CA" }
      let!(:plants) { Plant.native_to("VT") }

      describe 'happy path - good attribute provided' do
        it 'returns an array of plants sorted by attribute' do
          expect(plants.sort_by_attr("common_name")).to eq([plant_2, plant_3, plant_1])
          expect(plants.sort_by_attr("temperature_min")).to eq([plant_3, plant_2, plant_1])
        end
      end

      describe 'sad path - bad attribute provided' do
        it 'returns the original collection' do
          expect(plants.sort_by_attr("depth_perception")).to eq([plant_1, plant_2, plant_3])
        end
      end
    end
  end
end
