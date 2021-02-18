FactoryBot.define do
  factory :screen_link do
    screen
    coordinates { { top: '10%', bottom: '80%', left: '10%', right: '80%' } }
  end
end
