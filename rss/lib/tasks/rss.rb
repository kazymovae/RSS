require 'rss'
require 'open-uri'

namespace :update do

  desc "Update the feeds"
  task :feeds => :environment do
    puts "Updating..."
    Feed.each do |feed|
      url = feed.link
      open(url) do |rss|
        feed = RSS::Parser.parse(rss)
        puts "Title: #{feed.channel.title}"
        feed.items.each do |item|
          puts "Item: #{item.title}"
          item = Item.create(feed_id: feed.id, title: item.title, description: item.description, link: item.link)
          item.save
        end
      end
    end
    puts " - > Done"
  end

end