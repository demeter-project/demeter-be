require 'rails_helper'

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many :plots }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :state_code }

    it { should validate_numericality_of :user_id }

    it { should validate_length_of(:zip_code).is_equal_to(5) }
    it { should validate_length_of(:state_code).is_equal_to(2) }
  end
end