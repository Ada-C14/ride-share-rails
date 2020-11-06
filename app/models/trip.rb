class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger


  validates :date, presence: true

  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}

  validates :cost, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :driver_id, numericality: { only_integer: true}

  validates :passenger_id, numericality: { only_integer: true}

end
