# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def format_date_as_month_and_year(date)
    date.strftime("%b %Y")
  end

  def format_date_as_year(date)
    date.strftime("%Y")
  end
end
