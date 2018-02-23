module ItemsHelper

  #https://stackoverflow.com/questions/23315807/word-wrapping-in-rails-4-app-not-working-at-all
  #/./ - Any character except a newline.
  #{n,m} - At least n and at most m times
  #\Z - Matches end of string. If string ends with a newline, it matches just before newline
  def wrap(s, width=100)
    s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1<br>").html_safe
  end

end

