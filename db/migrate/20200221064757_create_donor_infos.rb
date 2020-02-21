class CreateDonorInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :donor_infos do |t|
      t.references :seed, null: false, foreign_key: true
      t.string :donor_name
      t.string :house_number
      t.string :dzongkhag
      t.string :gewog
      t.string :dungkhag
      t.string :village

      t.timestamps
    end
  end
end
