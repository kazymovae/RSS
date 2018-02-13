module ItemsHelper

  def wrap(s, width=78)
    s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1<br>").html_safe
  end

end

#https://stackoverflow.com/questions/23315807/word-wrapping-in-rails-4-app-not-working-at-all