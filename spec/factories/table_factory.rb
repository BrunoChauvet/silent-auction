require 'factory_girl'

FactoryGirl.define do
  factory :user_group, aliases: [:table] do
    initialize_with { UserGroup.where(name: name).first_or_initialize }
    name 'Table 1'
    full_name 'The first VIP table'
    sort_order 1
  end
end