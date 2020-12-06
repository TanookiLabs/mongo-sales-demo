class AddExternalUrlToScreenLinks < ActiveRecord::Migration[6.0]
  def change
    change_column_null :screen_links, :destination_screen_id, true
    add_column :screen_links, :external_url, :string
  end
end
