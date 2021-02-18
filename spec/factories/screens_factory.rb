FactoryBot.define do
  factory :screen do
    project
    title { Faker::Lorem.sentence }
    image_url { Faker::Internet.url }
  end
end
