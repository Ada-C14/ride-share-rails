class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :date, presence: true
  validates :cost, presence: true


  def self.trip_cost
    return rand(500..10000)
  end


end
