class DemoSessionNote < ApplicationRecord
  belongs_to :demo_session
  belongs_to :screen, optional: true
end
