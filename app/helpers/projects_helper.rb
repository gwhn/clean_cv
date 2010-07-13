module ProjectsHelper
  def add_responsibility_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :responsibilities,
                       :partial => 'responsibility', :object => Responsibility.new
    end
  end

  def prefix(responsibility)
    "project[#{responsibility.new_record? ? 'new' : 'existing'}_responsibility_attributes][]"
  end
end
