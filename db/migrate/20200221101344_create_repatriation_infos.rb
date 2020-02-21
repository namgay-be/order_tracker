class CreateRepatriationInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :repatriation_infos do |t|
      t.string :repatriation_number
      t.datetime :repatriation_date
      t.integer :quantity
      t.integer :initial_germination_rate
      t.string :resistant
      t.string :susceptible
      t.string :condition
      t.string :donor_accession
      t.string :donor_name
      t.string :country
      t.string :organisation
      t.string :web_url
      t.string :email_id
      t.string :phone
      t.string :fax
      t.text :remarks

      t.timestamps
    end
  end
end
