# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def average_rating
    sum_of_ratings = 0.00
    average = 0.00
    if self.trips.empty?
      average
    else
      sum_of_ratings = self.trips.map { |trip|
        if trip.rating.nil?
          0.0
        else
          trip.rating.to_f
        end
      }.sum
      average = (sum_of_ratings / trips.length).to_f.round(2)
      return average
    end
  end

  def total_earnings
    if self.trips.nil?
      return 0
    else
      total_income = 0

      total_income = self.trips.sum do |trip|
          if trip.cost.nil?
            0
          elsif trip.cost <= 165
            (trip.cost * 0.80).round(2)
          else
            ((trip.cost.to_f - 165) * 0.80).round(2)
          end
      end
      return "$#{(total_income / 100.0).round(2)}"
    end
  end
end
