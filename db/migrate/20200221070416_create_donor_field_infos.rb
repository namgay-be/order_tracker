class CreateDonorFieldInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :donor_field_infos do |t|
      t.references :seed, null: false, foreign_key: true
      t.decimal :latitude, precision: 10, scale: 3
      t.decimal :longitude, precision: 10, scale: 3
      t.decimal :altitude, precision: 10, scale: 3
      t.string :soil_culture
      t.string :soil_texture
      t.string :topography

      t.timestamps
    end
  end
end
