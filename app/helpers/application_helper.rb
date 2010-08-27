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
    if options[:on_ready_wrapper]
      script = javascript_tag <<JS
        $(function(){
          #{script}
        });
JS
    end
    script
  end

  def dynamic_tooltip_javascript_for(selector, options = {})
    options = {:position => 'top center',
               :on_ready_wrapper => true}.merge(options)
    script = <<JS
      $("#{selector}").tooltip({
        effect:"slide",
        position: "#{options[:position]}",
        delay: 750,
        tipClass: "options"
      });
      $("#{selector}").dynamic({
        bottom: {
          direction: "down"
        }
      });
JS
    if options[:on_ready_wrapper]
      script = javascript_tag <<JS
        $(function(){
          #{script}
        });
JS
    end
    script
  end
end
