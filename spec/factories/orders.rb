require 'faker'
FactoryBot.define do
  factory :order do
    name Faker::Name.name
  end
end
