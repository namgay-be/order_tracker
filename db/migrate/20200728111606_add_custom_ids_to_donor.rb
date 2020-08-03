class AddCustomIdsToDonor < ActiveRecord::Migration[6.0]
  def change
    add_column :donor_infos, :custom_ids, :integer, array: true, default: []
  end
end
