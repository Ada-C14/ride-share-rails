class Passenger < ApplicationRecord

  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_amount_charged
    # books_with_year = self.books.where.not(publication_date: nil
    trips_with_cost = self.trips.where.not(cost: nil)
    # years_published = author.books.map { |book| book.publication_date }
    total_amount_charged = trips_with_cost.map{ |trip| trip.cost}
    # return first_book.publication_date
    return total_amount_charged.sum
  end

end
