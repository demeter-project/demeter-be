require 'rails_helper'

RSpec.describe PlantFacade, :vcr do
  describe 'class methods' do
    describe '::hz_range_high(zip_code)' do
      it 'takes a zip_code as an arg, returns an integer representing lowest avg winter temp in a given zip_code' do
        expect(PlantFacade.hz_range_high('05408')).to be_an Integer
      end

      it 'should return nil if info not present for zip' do
        expect(PlantFacade.hz_range_high('99999')).to be nil
      end
    end
  end
end