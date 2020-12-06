class SalesItem < ApplicationRecord
  belongs_to :screen, inverse_of: :sales_items

  enum item_type: %i(info)

  validates :topic, :content, presence: true
end
