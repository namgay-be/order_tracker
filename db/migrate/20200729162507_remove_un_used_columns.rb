class RemoveUnUsedColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :cultivation_infos, :requires_multiplication, :boolean
  end
end
