class CreateCollectionInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :collection_infos do |t|
      t.references :seed, null: false, foreign_key: true
      t.string :collection_number, unique: true, index: true
      t.string :mission_number
      t.datetime :collection_date
      t.string :collection_source
      t.string :collectors_name
      t.text :collection_note

      t.timestamps
    end
  end
end
