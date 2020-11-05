class Driver < ApplicationRecord
  has_many :trips

  def toggle_available
    self.update(available: !self.available)
  end

end
