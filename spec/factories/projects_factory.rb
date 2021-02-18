FactoryBot.define do
  factory :project do
    title { Faker::Lorem.sentence }

    trait :with_screens do
      transient do
        screens_count { 3 }
      end

      screens do
        s = Array.new(screens_count) { association(:screen) }
        s[0].root = true
        s
      end
    end
  end
end
