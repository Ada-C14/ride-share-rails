class Trip < ApplicationRecord
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true}
  validates :cost, presence: true, numericality: { greater_than: 0 }

  belongs_to :driver
  belongs_to :passenger
end
