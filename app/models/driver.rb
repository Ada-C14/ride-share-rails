class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true

  validates :vin, presence: true, uniqueness: true

  def change_status
    if self.availability_status
      self.availability_status = false
    else
      self.availability_status = true
    end
    self.save
    return
  end

end
