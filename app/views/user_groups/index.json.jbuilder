json.array!(@user_groups) do |user_group|
  json.extract! user_group, :name, :sort_order
  json.url user_group_url(user_group, format: :json)
end
