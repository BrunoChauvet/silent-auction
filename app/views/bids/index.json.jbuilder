json.array!(@bids) do |bid|
  json.extract! bid, :price, :item, :user
  json.url bid_url(bid, format: :json)
end
