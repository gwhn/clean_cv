# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def remove_child_link(name, form_builder, html_options = {})
    form_builder.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", html_options)
  end

  def add_child_link(name, association, html_options = {})
    html_options[:"data-association"] ||= association
    link_to name, "javascript:void(0)", html_options
  end

  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f

    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for association, options[:object], :child_index => "new_#{association}" do |f|
        render :partial => options[:partial], :locals => {options[:form_builder_local] => f}
      end
    end
  end
  
  def sortable_javascript_for(selector, item_class, qs, url, options = {})
    options = {:handle_class => '.handle',
               :on_ready_wrapper => true}.merge(options)
    script = <<JS
$("#{selector}").sortable({
  axis: "y",
  dropOnEmpty: false,
  handle: "#{options[:handle_class]}",
  cursor: "move",
  items: "#{item_class}",
  opacity: 0.4,
  scroll: true,
  placeholder: "ui-state-highlight",
  update: function() {
    $.ajax({
      type: "put",
      data: $("#{selector}").sortable("serialize") + "#{qs}",
      dataType: "script",
      complete: function(request){
        $("#{selector}").effect("highlight");
      },
      url: "#{url}"
    });
  }
});
$("#{selector}").disableSelection();
JS
    script = jquery_on_ready(script) if options[:on_ready_wrapper]
    script
  end

  def dynamic_tooltip_javascript_for(selector, options = {})
    options = {:effect => 'slide',
               :position => 'top center',
               :delay => 750,
               :tip_class => 'options',
               :on_ready_wrapper => true}.merge(options)
    script = <<JS
$("#{selector}").tooltip({
  effect:"#{options[:effect]}",
  position: "#{options[:position]}",
  delay: #{options[:delay]},
  tipClass: "#{options[:tip_class]}"
});
$("#{selector}").dynamic({bottom: {direction: "down"}});
JS
    script = jquery_on_ready(script) if options[:on_ready_wrapper]
    script
  end

  def jquery_on_ready(script)
    javascript_tag "$(function(){#{script}});"
  end

  def formatted_date_range(start_date, end_date, options = {})
    options = {:date_format => :month_and_year}.merge(options)
    formatted_start_date = h start_date.to_date.to_s(options[:date_format])
    if end_date.to_date.selected?
      "#{formatted_start_date} - #{h end_date.to_date.to_s(options[:date_format])}"
    else
      "#{formatted_start_date} - present"
    end
  end

  def visualize_timeline(data, target)
    Seer::visualize(
            data,
            :as => :line_chart,
            :in_element => target,
            :series => {
                    :series_label => 'name',
                    :data_label => 'year',
                    :data_method => 'months',
                    :data_series => data.map { |model| model.stats }
            },
            :chart_options => {
                    :height => 350,
                    :width => 600,
                    :colors => ['#0066aa', '#fdb020', '#222222'],
                    :title => 'Timeline',
                    :point_size => 3,
                    :axis_font_size => 8,
                    :legend_font_size => 10,
                    :title_font_size => 14
            }
    )
  end

end
