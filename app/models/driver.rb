class Driver < ApplicationRecord
  has_many :trips

  def mark_unavailable
    self.available = false
    self.save
  end
end
