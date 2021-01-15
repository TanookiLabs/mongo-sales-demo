class SalesItem < ApplicationRecord
  belongs_to :screen, inverse_of: :sales_items

  enum item_type: { pitch: 0, faq: 1, questions: 2, collateral: 3, custom: 4 }

  validates :content, presence: true
end
