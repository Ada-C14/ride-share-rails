class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true
end
