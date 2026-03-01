FactoryBot.define do
  factory :client do
    studio
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    document_type { "DNI" }
    document_number { Faker::Number.unique.number(digits: 8).to_s }
    sequence(:email) { |n| "client#{n}@example.com" }
    phone { Faker::PhoneNumber.phone_number }
  end
end
