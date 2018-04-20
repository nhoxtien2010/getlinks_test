FactoryBot.define do
  factory :user do
    email 'admin@example.com'
    password 'password'
    is_admin true
  end
end
