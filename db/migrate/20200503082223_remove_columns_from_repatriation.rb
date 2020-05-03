class RemoveColumnsFromRepatriation < ActiveRecord::Migration[6.0]
  def change
    remove_column :repatriation_infos, :susceptible, :string
    remove_column :repatriation_infos, :resistant, :string
  end
end
