class Driver < ApplicationRecord
  has_many :trips
  validates :name, :vin, presence: true

  def total_earnings

  end

  def average_rating

  end
end
