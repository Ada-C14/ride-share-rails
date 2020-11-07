class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :driver_id, :passenger_id, :date, :cost, presence: true
  validates :cost, numericality: true
end
