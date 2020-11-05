class Driver < ApplicationRecord
  has_many :trips
  # must provide an email address and it must include an @ sign
  validates :name, presence: true

  # usernames must be unique and between 5 and 25 characters in length
  validates :vin, uniqueness: true, length: { is: 17}
end

