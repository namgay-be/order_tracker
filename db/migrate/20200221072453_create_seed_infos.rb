class CreateSeedInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :seed_infos do |t|
      t.references :seed, null: false, foreign_key: true
      t.string :local_name
      t.string :local_variety_name
      t.string :sample_status

      t.timestamps
    end
  end
end
