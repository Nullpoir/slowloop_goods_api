FactoryBot.define do
  factory :user do
    provider { 'email' }
    uid { Faker::Internet.email }
    email { Faker::Internet.email }
    password { "Aa@123456" }
    password_confirmation { "Aa@123456" }
  end
end
