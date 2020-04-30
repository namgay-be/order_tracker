class CreatePacketCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :packet_counts do |t|
      t.references :gene_bank, null: false, foreign_key: true
      t.integer :germination_count
      t.integer :regeneration_count
      t.integer :rest_count
      t.integer :active_collection_count
      t.integer :characterization_count
      t.integer :duplicate_count

      t.timestamps
    end
  end
end
