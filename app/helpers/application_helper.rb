module ApplicationHelper
  def dollar_format(cents)
    dollars = number_to_currency(cents/100)
    return dollars
  end
end
