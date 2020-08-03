class CreateGewogs < ActiveRecord::Migration[6.0]
  def change
    create_table :gewogs do |t|
      t.string :name
      t.references :dzongkhag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
