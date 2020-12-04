class SalesItem < ApplicationRecord
  belongs_to :screen, inverse_of: :sales_items

  enum type: %i(info)

  validates :content, presence: true
end
