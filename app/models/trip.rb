class Trip < ApplicationRecord
  belongs_to :driver, :passenger
end
