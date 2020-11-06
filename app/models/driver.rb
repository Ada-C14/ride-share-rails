class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true

  validates :vin, uniqueness: true, length: { is: 17 }

  validates :available




end


# must provide an email address and it must include an @ sign
validates :email, presence: true, format: {with: /@/}

# usernames must be unique and between 5 and 25 characters in length
validates :username, uniqueness: true, length: { in: 5..25 }

# age must be a number. An positive integer > 12, to be more precise.
validates :age, numericality: { only_integer: true, greater_than: 12 }