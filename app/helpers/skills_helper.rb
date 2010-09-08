module SkillsHelper
  def summarize_skills_by_category(categories)
    content_tag :table do
      caption = content_tag :caption, 'Technical Skills by Category'
      thead = content_tag :thead do
        content_tag :tr do
          categories.keys.inject('') do |r, k|
            r + content_tag(:th, h(k))
          end
        end
      end
      tbody = content_tag :tbody do
        content_tag :tr do
          categories.keys.inject('') do |r, k|
            r + content_tag(:td, nil) do
              categories[k].inject('') do |r2, s|
                r2 + s.name + content_tag(:br)
              end
            end
          end
        end
      end
      caption + thead + tbody
    end
  end
end
