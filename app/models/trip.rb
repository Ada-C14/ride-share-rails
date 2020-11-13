class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :cost, presence: true, numericality: {greater_than: 0}

end
