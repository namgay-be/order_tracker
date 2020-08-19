class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :store, null: false, foreign_key: true
      t.string :name
      t.integer :price
      t.boolean :available, default: true, null: false
      t.text :additional_info

      t.timestamps
    end
  end
end
