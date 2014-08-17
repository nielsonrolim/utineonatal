module ApplicationHelper
  def pre_dump(obj)
    content_tag :pre do
      YAML::dump(obj)
    end
  end
end
