require 'factory_girl'

FactoryGirl.define do
  factory :category do
  	initialize_with { Category.where(name: name).first_or_initialize }
    name 'Electronics'
  end
end