class Screen < ApplicationRecord
  belongs_to :project, inverse_of: :screens

  has_many :links, class_name: 'ScreenLink', dependent: :destroy, inverse_of: :screen
  has_many :incoming_links, class_name: 'ScreenLink', dependent: :destroy, foreign_key: :destination_screen_id, inverse_of: :destination_screen
  has_many :sales_items, dependent: :destroy, inverse_of: :screen
  has_many :demo_session_notes, inverse_of: :screen, dependent: :nullify

  validates :title, :image_url, presence: true
  validates :root, inclusion: { in: [true, false] }

  accepts_nested_attributes_for :sales_items, allow_destroy: true
end
