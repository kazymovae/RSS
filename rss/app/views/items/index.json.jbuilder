json.feed do
  json.set! 'title', @feed.title
  json.set! 'description', @feed.description
  json.items @items, partial: 'items/item', as: :item
end
