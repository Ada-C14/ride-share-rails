class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :rating, :inclusion => { :in => [1,2,3,4,5,nil] }
end
