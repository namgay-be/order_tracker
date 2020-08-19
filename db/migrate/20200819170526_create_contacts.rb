class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :store, null: false, foreign_key: true
      t.string :name
      t.string :phone
      t.integer :contact_type, default: 0, null: false

      t.timestamps
    end
  end
end
