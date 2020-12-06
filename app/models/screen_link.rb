class ScreenLink < ApplicationRecord
  belongs_to :screen, inverse_of: :links
  belongs_to :destination_screen, optional: true, inverse_of: :incoming_links, class_name: 'Screen'

  validates :coordinates, presence: true
end
