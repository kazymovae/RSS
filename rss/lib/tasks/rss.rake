require 'rss'
require 'open-uri'
require 'tasks/rss_helper'

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
          item_exists = Item.find_by(title: item.title, description: RssHelper.strip_html_tags(item.description), link: item.link)
          if item_exists.blank?
            puts "Item: #{item.title}"
            count += 1
            item = Item.create(feed_id: feed.id, title: item.title, description: RssHelper.strip_html_tags(item.description), link: item.link)
            item.save
          end  
        end
      end
    end
    case count
    when 0
      puts " - > Nothing was retieved"
    when 1
      puts " - > #{count} item was retieved"
    else
      puts " - > #{count} items were retirved"
    end  
    puts " - > Done"
  end

end