class AddBannedColumnToSeed < ActiveRecord::Migration[6.0]
  def change
    add_column :seeds, :banned, :boolean, default: false, null: false 
  end
end
