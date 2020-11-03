class Trip < ApplicationRecord
  belongs_to :passenger, :driver
end
