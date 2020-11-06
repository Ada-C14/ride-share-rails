class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :rating, :inclusion => { :in => 1..5 }, on: :update

  def self.generate_cost
    return rand(8.0..35.0).round(2)
  end

  def self.assign_driver
    return Driver.find_by(available: 'true').id
  end

  def change_driver_status
    driver = Driver.find_by(id: self.driver_id)
    driver.available = 'false'
    driver.save
  end
end
