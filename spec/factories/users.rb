FactoryBot.define do
  factory :user do
    studio
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    role { :titular }
    phone { Faker::PhoneNumber.phone_number }
    matricula { "T#{rand(1..100)} F#{rand(1..500)}" }
  end
end
