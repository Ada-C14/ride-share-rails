class Driver < ApplicationRecord
  has_many :trips
  has_many :passangers
end