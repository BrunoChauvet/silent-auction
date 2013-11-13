json.array!(@items) do |item|
  json.extract! item, :code, :name, :description, :category, :start_price, :image
  json.url item_url(item, format: :json)
end
