class CreateForeignSeedInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :foreign_seed_infos do |t|
      t.references :foreign_seed, foreign_key: { to_table: :seeds }
      t.string :crop_name
      t.string :family
      t.string :genus
      t.string :species
      t.string :sub_texa
      t.string :material_type
      t.string :classification
      t.text :characteristics

      t.timestamps
    end
  end
end
