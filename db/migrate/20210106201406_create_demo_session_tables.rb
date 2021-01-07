class CreateDemoSessionTables < ActiveRecord::Migration[6.0]
  def change
    create_table :demo_sessions, id: :uuid do |t|
      t.references :project, type: :uuid, null: false, index: true, foreign_key: true
      t.references :user, type: :uuid, null: true, index: true, foreign_key: true
      t.datetime :ended_at
      t.timestamps
    end

    create_table :demo_session_notes, id: :uuid do |t|
      t.references :demo_session, type: :uuid, null: false, index: true, foreign_key: true
      t.references :screen, type: :uuid, null: true, index: true, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.timestamps
    end
  end
end
