class AddColumnToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :email, :string
    add_column :customers, :contact_number, :string
    add_column :customers, :country, :string
  end
end
