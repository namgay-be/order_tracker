class CreateDzongkhags < ActiveRecord::Migration[6.0]
  def change
    create_table :dzongkhags do |t|
      t.string :name
      t.timestamps
    end
  end
end
