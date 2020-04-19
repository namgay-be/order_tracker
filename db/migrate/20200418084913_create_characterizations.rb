class CreateCharacterizations < ActiveRecord::Migration[6.0]
  def change
    create_table :characterizations do |t|
      t.references :gene_bank, null: false, foreign_key: true
      t.decimal :weight, precision: 5, scale: 2
      t.integer :packets

      t.timestamps
    end
  end
end
