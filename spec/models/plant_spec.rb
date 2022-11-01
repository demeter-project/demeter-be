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
end
