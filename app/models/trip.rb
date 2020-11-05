class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :driver_id, presence: true
  validates :passenger_id, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :cost, presence: true, numericality: { greater_than: 0 }
  # validates :date, presence: true

  def cost_in_dollars
    return (cost / 100.0).round(2)
  end

  def cost_in_dollars=(value)
    self.cost = value.to_f * 100
  end
end
