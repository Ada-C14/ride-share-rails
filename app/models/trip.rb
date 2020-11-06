require 'money'
class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  # attribute :rating, default: rand(1...5)
  validates :date, presence: { message: "can't be blank" }
  validates :driver, presence: { message: "can't be blank" }
  validates :passenger, presence: { message: "can't be blank" }
  validates :cost, presence: { message: "can't be blank" }

  def format_cost
    Money.new(self.cost, "USD").format
  end
end
