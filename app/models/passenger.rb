class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true

  validates :phone_num, presence: true # Don't worry about how a passenger's phone number is formatted

end
