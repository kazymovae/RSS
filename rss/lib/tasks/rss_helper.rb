class RssHelper

  def self.strip_html_tags(string)
    ActionView::Base.full_sanitizer.sanitize(string)
  end

end