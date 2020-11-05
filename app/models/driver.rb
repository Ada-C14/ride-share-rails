class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true, length: 17

  def toggle_available
    self.update(available: !self.available)
  end

end
