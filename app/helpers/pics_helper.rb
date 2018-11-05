module PicsHelper
  def linked_users(caption)
    caption.gsub /@([\w]+)/ do |match|
      link_to match, profile_path($1)
    end.html_safe
  end
end
