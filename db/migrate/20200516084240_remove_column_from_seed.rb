class RemoveColumnFromSeed < ActiveRecord::Migration[6.0]
  def change
    remove_column :seeds, :characteristics, :text
  end
end
