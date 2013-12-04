require 'factory_girl'

FactoryGirl.define do
  factory :user do
    initialize_with { User.where(first_name: first_name, last_name: last_name).first_or_initialize }
    title 'Mr'
    first_name 'John'
    last_name 'Smith'
    pin 1234
    admin false
    user_group
  end
end