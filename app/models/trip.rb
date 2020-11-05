class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  validates driver_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates passenger_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates date, presence: true
  validates rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates cost, numericality: { only_integer: true, greater_than: 0 }

end
