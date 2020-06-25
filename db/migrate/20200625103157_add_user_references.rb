class AddUserReferences < ActiveRecord::Migration[6.0]
  def change
    add_reference :seeds, :creator, foreign_key: { to_table: :users }
    add_reference :test_details, :creator, foreign_key: { to_table: :users }
    add_reference :gene_banks, :creator, foreign_key: { to_table: :users }
    add_reference :distribution_infos, :creator, foreign_key: { to_table: :users }
    add_reference :customers, :creator, foreign_key: { to_table: :users }
    add_reference :donor_infos, :creator, foreign_key: { to_table: :users }
  end
end
