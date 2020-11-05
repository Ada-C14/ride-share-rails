class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  attribute :rating, default: rand(1...5)
  # attribute :cost, :integer, default: rand(1000..9000)

end
