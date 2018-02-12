require 'rss'
require 'open-uri'

namespace :update do

  desc "Update the feeds"
  task :feeds => :environment do
    puts "Updating..."
    Feed.find_each do |feed|
      url = feed.link
      open(url) do |rss|
        rss = RSS::Parser.parse(rss)
        puts "Title: #{rss.channel.title}"
        rss.items.each do |item|
          item_exists = Item.find_by(title: item.title, description: item.description, link: item.link)
          if item_exists.blank?
            puts "Item: #{item.title}"
            item = Item.create(feed_id: feed.id, title: item.title, description: item.description, link: item.link)
            item.save
          end  
        end
      end
    end
    puts " - > Done"
  end

end