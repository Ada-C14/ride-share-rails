class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, uniqueness: true, length: { is: 17}

  def self.find_available_driver
    return Driver.where(available: true).first
  end
  def mark_unavailable
    self.available = false
    self.save
  end
#  drivers total earnings
  #  driver gets 80% of the trip cost after a fee of $1.65 is subtracted
end

