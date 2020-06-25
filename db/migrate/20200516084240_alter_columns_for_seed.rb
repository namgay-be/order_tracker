class AlterColumnsForSeed < ActiveRecord::Migration[6.0]
  def change
    remove_column :seeds, :characteristics, :text
    add_reference :seeds, :donor_info, foreign_key: true
  end
end
