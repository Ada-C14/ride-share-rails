class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  # validates :rating, length: { in: 1..5}
  # validates :cost, numericality: { only_integer: true, greater_than: 0 }
end
