class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger


  validates :date, presence: true

  validates :rating, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}

  validates :cost, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
