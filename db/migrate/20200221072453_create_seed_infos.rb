class CreateSeedInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :seed_infos do |t|
      t.references :seed, null: false, foreign_key: true
      t.string :crop_name
      t.string :local_name
      t.string :local_variety_name
      t.string :family
      t.string :genus
      t.string :species
      t.string :sub_texa
      t.string :material_type
      t.string :classification
      t.string :resistant
      t.string :susceptible
      t.string :sample_status
      t.integer :seed_status, default: 0, null: false

      t.timestamps
    end
  end
end
