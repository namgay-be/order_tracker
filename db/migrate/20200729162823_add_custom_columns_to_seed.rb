class AddCustomColumnsToSeed < ActiveRecord::Migration[6.0]
  def change
    add_column :seeds, :rep_id, :integer
    add_column :seeds, :old_data, :boolean, default: false, null: false
  end
end
