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

  def sortable_javascript_for(qs, selector, item_class, url)
    javascript_tag <<JS
      $(function() {
        $("#{selector}").sortable({
          axis: "y",
          dropOnEmpty: false,
          handle: ".handle",
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
      });
JS
  end

  def dynamic_tooltip_javascript_for(selector, position = 'top center')
    javascript_tag <<JS
      $(function(){
        $("#{selector}").tooltip({
          effect:"slide",
          position: "#{position}",
          delay: 1000,
          tipClass: "options"
        }).dynamic({
          bottom: {
            direction: "down"
          }
        });
      });
JS
  end
end
