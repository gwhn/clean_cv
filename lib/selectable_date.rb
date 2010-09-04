module SelectableDate
  def selected?
    not (day == 1 and month == 1 and year == 1)
  end
end

class Date
  include SelectableDate
end
