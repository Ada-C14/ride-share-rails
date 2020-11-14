class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def format_cost
    Money.new(self.cost, "USD").format
  end
end
