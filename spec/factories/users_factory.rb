FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user.#{n}@markreist.com" }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
