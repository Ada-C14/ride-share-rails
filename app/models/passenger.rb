class Passenger < ApplicationRecord
  validates :name, presence: true
  validates :phone_num, presence: true

  has_many :trips
end
