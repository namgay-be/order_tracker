class CreateDistributionInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :distribution_infos do |t|
      t.references :customer, foreign_key: true
      t.references :seed, foreign_key: true
      t.datetime :requested_date
      t.datetime :supplied_date
      t.integer :package_type, default: 0, null: false
      t.integer :quantity
      t.text :purpose
      t.text :remarks
      t.boolean :finalized, default: false, null: false

      t.timestamps
    end
  end
end
