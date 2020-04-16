class CreateTestDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :test_details do |t|
      t.decimal :germination_rate, precision: 5, scale: 2
      t.datetime :germination_date
      t.decimal :moisture_content, precision: 5, scale: 2
      t.datetime :moisture_date
      t.text :remarks
      t.datetime :date_stored
      t.references :seed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
