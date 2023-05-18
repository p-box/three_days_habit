FactoryBot.define do
  factory :user do
    name { Faker::Name }
    email { Faker::Internet.email }
    password {'password'}
    password_confirmation {'password'}
  end
end
