class AddInfoTypeToSalesItems < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        execute("UPDATE sales_items SET item_type = 4")
      end
      dir.down do |dir|
        execute("DELETE FROM sales_items WHERE item_type < 4")
        execute("UPDATE sales_items SET item_type = 0")
      end
    end
    change_column_null :sales_items, :topic, true
  end
end
