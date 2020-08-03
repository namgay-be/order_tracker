class AlterAttributesFromDonor < ActiveRecord::Migration[6.0]
  def change
    remove_column :donor_infos, :dzongkhag, :string
    remove_column :donor_infos, :gewog, :string
    add_reference :donor_infos, :gewog, foreign_key: true
  end
end
