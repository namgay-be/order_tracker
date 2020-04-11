class CreateSeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :seeds do |t|
      t.string :type
      t.string :crop_name
      t.string :family
      t.string :genus
      t.string :species
      t.string :sub_texa
      t.string :material_type
      t.string :classification
      t.string :resistant
      t.string :susceptible
      t.integer :seed_status, default: 0, null: false
      t.text :characteristics

      t.timestamps
    end
  end
end
