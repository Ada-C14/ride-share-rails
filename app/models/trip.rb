class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :rating, numericality: { in: 1..5 }, on: :update
end
