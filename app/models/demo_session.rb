class DemoSession < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  has_many :notes, class_name: 'DemoSessionNote', dependent: :destroy, inverse_of: :demo_session

  validates :title, presence: true

  scope :completed, -> { where("ended_at IS NOT NULL OR updated_at < (NOW() - INTERVAL '2 hours')") }
  scope :active, -> { where("ended_at IS NULL AND updated_at >= (NOW() - INTERVAL '2 hours')") }

  def closed_at
    ended_at || updated_at
  end
end
