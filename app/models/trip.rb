class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  # validates :rating, numericality: { only_integer: true, in: 1..5 }
end
