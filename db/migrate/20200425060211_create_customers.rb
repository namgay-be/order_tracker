class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :cust_id, index: true
      t.string :name
      t.string :designation
      t.string :organisation
      t.string :status
      t.text :address

      t.timestamps
    end
  end
end
