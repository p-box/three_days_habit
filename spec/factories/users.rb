FactoryBot.define do
  factory :user do
    name                  {'test'}
    email                 {'test@gmail.com'}
    password              {'123456'}
    password_confirmation {'123456'}
  end
end
