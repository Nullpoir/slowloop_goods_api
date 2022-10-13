FactoryBot.define do
  factory :good do
    name { Faker::Device.model_name }
    description { Faker::Lorem.sentence }
    isbn { "ISBN#{Faker::Number.rand(9)}-#{Faker::Number.rand(9999)}-#{Faker::Number.rand(9999)}" }
    jan { "#{Faker::Number.rand(999999999)}" }
  end
end
