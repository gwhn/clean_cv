class SearchQuery
  attr_accessor :filter_options

  def initialize(filter_options = {})
    @filter_options = filter_options
  end

  def search
    @filter_options[:search] ||= ''
  end

  def sorted_by
    @filter_options[:sorted_by] ||= ''
  end
end

