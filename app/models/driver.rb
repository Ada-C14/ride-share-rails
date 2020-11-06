class Driver < ApplicationRecord
  has_many :trips

  validates :name, :vin, presence: true
  validates :vin, uniqueness: true
end

