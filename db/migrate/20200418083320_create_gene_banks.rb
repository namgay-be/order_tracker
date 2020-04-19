class CreateGeneBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :gene_banks do |t|
      t.references :seed, null: false, foreign_key: true
      t.string :accession_number
      t.datetime :packaging_date

      t.timestamps
    end
  end
end
