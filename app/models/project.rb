class Project < ApplicationRecord
  validates :title, presence: true
  has_many :screens, inverse_of: :project, dependent: :destroy

  def root_screen
    screens.order(root: :desc, created_at: :asc).first
  end
end
