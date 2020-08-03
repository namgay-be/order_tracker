class AddCustomIdsToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :custom_ids, :integer, array: true, default: []
  end
end
