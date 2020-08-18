class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, index: true
      t.string :dzongkhag
      t.string :gewog
      t.string :village
      t.string :sector
      t.string :latitude
      t.string :longitude
      t.text :additional_info

      t.timestamps
    end
  end
end
