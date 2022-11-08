class Garden < ApplicationRecord
  has_many :plots

  validates_presence_of :name, :user_id, :zip_code, :state_code

  validates_numericality_of :user_id

  validates :zip_code, length: { is: 5 }, zipcode: {country_code: :us, message: "is not a valid US postal code"}
  validates :state_code, length: { is: 2 }
end
