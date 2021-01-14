class AddTitleToDemoSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :demo_sessions, :title, :string
    DemoSession.update_all(title: '[untitled]')
    change_column_null :demo_sessions, :title, :false
  end
end
