require 'rss'
require 'open-uri'

def strip_html_tags(string)
    ActionView::Base.full_sanitizer.sanitize(string)
end

namespace :update do

  desc "Update the feeds"
  task :feeds => :environment do
    puts "Updating..."
    count = 0
    Feed.find_each do |feed|
      url = feed.link
      open(url) do |rss|
        rss = RSS::Parser.parse(rss)
        puts "Title: #{rss.channel.title}"
        rss.items.each do |item|
          item_exists = Item.find_by(title: item.title, description: strip_html_tags(item.description), link: item.link)
          if item_exists.blank?
            puts "Item: #{item.title}"
            count += 1
            item = Item.create(feed_id: feed.id, title: item.title, description: strip_html_tags(item.description), link: item.link)
            item.save
          end  
        end
      end
    end
    case count
    when 0
      puts " - > Nothing was retieved"
    when 1
      puts " - > #{count} was retieved"
    else
      puts " - > #{count} were retirved"
    end  
    puts " - > Done"
  end

end