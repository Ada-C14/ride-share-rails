class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def mark_unavailable
    self.available = false
    self.save
  end
end
