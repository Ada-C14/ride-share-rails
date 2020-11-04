class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :driver, presence: true
  validates :passenger, presence: true
  validates :date, presence: true
  validates :cost, presence: true, numericality: { only_integer: true }
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
end
