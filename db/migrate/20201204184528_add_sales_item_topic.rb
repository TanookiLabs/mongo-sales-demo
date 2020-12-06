class AddSalesItemTopic < ActiveRecord::Migration[6.0]
  def change
    add_column :sales_items, :topic, :string, null: false
    rename_column :sales_items, :type, :item_type
  end
end
