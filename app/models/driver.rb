class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, length: { is: 17 }
  # validates :available, presence: true, inclusion: { in: [true, false] }

end
