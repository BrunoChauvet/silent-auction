require 'factory_girl'

FactoryGirl.define do
  factory :item do
    initialize_with { Item.where(code: code).first_or_initialize }
  	code '101'
    name 'iPad 4G'
    start_price 300
    bid_increment 10
    category
  end
end