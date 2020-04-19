class CreateBaseCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :base_collections do |t|
      t.references :gene_bank, null: false, foreign_key: true
      t.decimal :germination_weight, precision: 5, scale: 2
      t.integer :germination_packets
      t.decimal :regeneration_weight, precision: 5, scale: 2
      t.integer :regeneration_packets
      t.decimal :rest_weight, precision: 5, scale: 2
      t.integer :rest_packets

      t.timestamps
    end
  end
end
