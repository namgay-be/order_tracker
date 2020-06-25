class RemoveSeedReferenceFromDonor < ActiveRecord::Migration[6.0]
  def change
    remove_reference :donor_infos, :seed
  end
end
