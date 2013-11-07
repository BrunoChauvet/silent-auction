json.array!(@users) do |user|
  json.extract! user, :title, :first_name, :last_name, :pin, :user_group
  json.url user_url(user, format: :json)
end
