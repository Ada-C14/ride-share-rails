module ApplicationHelper
  def cents_dollars(cents)
    number_to_currency(cents/100.0.round(2))
  end
end
