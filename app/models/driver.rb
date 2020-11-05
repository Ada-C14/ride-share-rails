class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, uniqueness: true, length: { is: 17}

  # def self.is_available?
  #   return where(available: true).first
  # end
end

