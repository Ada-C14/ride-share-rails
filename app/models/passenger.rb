class Passenger < ApplicationRecord
  has_many :trips

  #validates :name, presence: true
  #validates :phone_num, presence: true, numericality: { only_integer: true }, length: { is: 10}

end
