class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :rating, :numericality => { :greater_than_or_equal_to => 0 }, :inclusion => { :in => 1..5 }, on: :update
  validates :date, presence: true
  validates :cost, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
  validates :driver_id, presence: true
  validates :passenger_id, presence: true

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
