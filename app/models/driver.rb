# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def trip_list
    skip
  end

  def average_rating
    sum_of_ratings = 0.00
    average = 0.00
    if @trips.empty?
      average
    else
      @trips.map do |trip|
        if trip.rating.nil?
          next
        else
          sum_of_ratings += trip.rating.to_f
        end
      end
      average = (sum_of_ratings / @trips.length).to_f.round(2)
      average
    end
  end

  def total_earnings
    if @trips.empty?
      return 0
    else
      total_income = 0

      @trips.each do |trip|
        total_income +=
          if trip.cost.nil?
            0
          elsif trip.cost <= 1.65
            (trip.cost * 0.80).round(2)
          else
            ((trip.cost.to_f - 1.65) * 0.80).round(2)
          end
      end
      return total_income
    end
  end


end
