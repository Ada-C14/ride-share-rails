class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :driver, presence: true
  validates :passenger, presence: true
  validates :date, presence: true
  validates :cost, presence: true, numericality: { only_integer: true }
end
