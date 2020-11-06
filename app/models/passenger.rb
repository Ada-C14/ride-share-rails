class Passenger < ApplicationRecord
    has_many :trips
    validates :phone_num, numericality: { only_integer: true }
    validates :name, presence: true
end
