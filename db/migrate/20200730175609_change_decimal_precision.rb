class ChangeDecimalPrecision < ActiveRecord::Migration[6.0]
  def change
    change_column :active_collections, :weight, :decimal, precision: 9, scale: 2
    change_column :characterizations, :weight, :decimal, precision: 9, scale: 2
    change_column :duplicates, :weight, :decimal, precision: 9, scale: 2
    change_column :base_collections, :regeneration_weight, :decimal, precision: 9, scale: 2
    change_column :base_collections, :rest_weight, :decimal, precision: 9, scale: 2
    change_column :base_collections, :germination_weight, :decimal, precision: 9, scale: 2
  end
end
