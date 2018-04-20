require 'faker'
FactoryBot.define do
  factory :product do
    name Faker::Name.name
    price Faker::Number.number(3)
  end
end
