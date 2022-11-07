class Garden < ApplicationRecord
  has_many :plots, dependent: :destroy

  validates_presence_of :name, :user_id, :zip_code, :state_code

  validates_numericality_of :user_id

  validates :zip_code, length: { is: 5 }
  validates :state_code, length: { is: 2 }
end
