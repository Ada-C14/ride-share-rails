class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  validates :cost, presence: true, numericality: true
end
