class CreateInitialTables < ActiveRecord::Migration[6.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :title, null: false
      t.timestamps
    end

    create_table :screens, id: :uuid do |t|
      t.references :project, type: :uuid, null: false, index: true, foreign_key: true
      t.string :title, null: false
      t.string :image_url, null: false
      t.boolean :root, null: false, default: false
      t.timestamps
    end

    create_table :screen_links, id: :uuid do |t|
      t.references :screen, type: :uuid, null: false, index: true, foreign_key: true
      t.json :coordinates, null: false
      t.references :destination_screen, type: :uuid, null: false, index: true, foreign_key: { to_table: :screens }
      t.timestamps
    end

    create_table :sales_items, id: :uuid do |t|
      t.references :screen, type: :uuid, null: false, index: true, foreign_key: true
      t.integer :type, null: false, default: 0
      t.text :content, null: false
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Project.create(title: 'Default')
      end
    end
  end
end
