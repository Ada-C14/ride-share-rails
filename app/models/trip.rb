class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :date, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0 ,less_than: 6 }, allow_nil: true
  validates :cost, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  def money
    in_dollars =  self[:cost]/ 100.00
    return '%.2f' % in_dollars
  end

end
