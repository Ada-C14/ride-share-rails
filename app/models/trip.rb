class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  # attribute :rating, default: rand(1...5)
  validates :date, presence: true
  validates :driver, presence: true
  validates :passenger, presence: true
  validates :cost, presence: true
end
