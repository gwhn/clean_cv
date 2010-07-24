# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def error_handling_form_for(record_or_name_or_array, * args, & proc)
    options = args.detect { |arg| arg.is_a?(Hash) }
    if options.nil?
      options = {:builder => ErrorHandlingFormBuilder}
      args << options
    end
    options[:builder] = ErrorHandlingFormBuilder unless options.nil?
    form_for(record_or_name_or_array, * args, & proc)
  end

  def remove_child_link(name, form_builder, html_options = {})
    form_builder.hidden_field(:_delete) + link_to(name, "javascript:void(0)", html_options)
  end

  def add_child_link(name, association, html_options = {})
    html_options[:"data-association"] ||= association
    link_to(name, "javascript:void(0)", html_options)
  end

  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f

    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
      end
    end
  end

end
