FactoryBot.define do
  factory :studio do
    name { Faker::Company.name }
    sequence(:email) { |n| "studio#{n}@example.com" }
    phone { Faker::PhoneNumber.phone_number }
    cuit { Faker::Number.number(digits: 11).to_s }
    timezone { "America/Argentina/Buenos_Aires" }
  end
end
