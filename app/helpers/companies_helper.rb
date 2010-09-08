module CompaniesHelper
  def visualize_work_timeline(companies, target)
    series = companies.map { |c| c.stats }

    Seer::visualize(
            companies,
            :as => :line_chart,
            :in_element => target,
            :series => {
                    :series_label => 'name',
                    :data_label => 'year',
                    :data_method => 'months',
                    :data_series => series
            },
            :chart_options => {
                    :height => 350,
                    :width => 600,
                    :colors => ['#0066aa', '#fdb020', '#222222'],
                    :title => 'Timeline',
                    :title_y => 'Months',
                    :point_size => 3,
                    :axis_font_size => 8
            }
    )
  end
end
