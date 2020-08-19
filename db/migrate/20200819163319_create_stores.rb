class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :category, default: 0, null: false
      t.string :phone_1
      t.string :phone_2
      t.string :email
      t.boolean :available, default: true, null: false
      t.references :service_area, foreign_key: true

      t.timestamps
    end
  end
end
