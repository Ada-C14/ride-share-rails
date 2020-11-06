class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  # validates :rating, numericality: { only_integer: true, in: 1..5}
  validates :cost, presence: true, numericality: true
  validates_date :date, presence: true, before: Date.tomorrow
  validates :driver_id, presence: true, numericality: true
  validates :passenger_id, presence: true, numericality: true

end
