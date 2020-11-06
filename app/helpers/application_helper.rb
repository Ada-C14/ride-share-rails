module ApplicationHelper
  def dollar_format(cents)
    if cents.nil?
      return "N/A"
    else
      dollars = number_to_currency(cents * 0.01)
    end

    return dollars
  end
end
