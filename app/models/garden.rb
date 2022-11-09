class Garden < ApplicationRecord
  has_many :plots, dependent: :destroy

  validates_presence_of :name, :user_id, :zip_code, :state_code
  validates_numericality_of :user_id
  validates :zip_code, length: { is: 5 }, zipcode: {country_code: :us, message: "is not a valid US postal code"}
  validates :state_code, length: { is: 2 }
  validate :zip_code_can_get_location

  private

  def zip_code_can_get_location
    response = LocationService.get_lat_lon(zip_code)
    if response[:features].blank? || zip_code =='99999'
      errors.add(:zip_code, "cannot be matched to valid US location")
    end
  end
end
