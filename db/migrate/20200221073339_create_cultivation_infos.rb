class CreateCultivationInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :cultivation_infos do |t|
      t.references :seed, null: false, foreign_key: true
      t.string :nursery_month
      t.string :planting_month
      t.string :harvesting_month
      t.string :cultivation_practice
      t.string :crop_system
      t.text :characteristics
      t.boolean :requires_multiplication, null: false, default: false

      t.timestamps
    end
  end
end
