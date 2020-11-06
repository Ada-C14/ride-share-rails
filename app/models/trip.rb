class Trip < ApplicationRecord

  belongs_to :passenger
  belongs_to :driver

  validates :rating, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

end
