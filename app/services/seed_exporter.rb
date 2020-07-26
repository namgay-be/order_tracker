class SeedExporter
  include ActiveModel::Validations
  include Assigner
  include ExportHelper

  attr_accessor :file, :sheet, :file_name, :seeds, :type

  def initialize(seeds:, type:)
    @seeds = seeds
    @type = type
    @file_name= (type == 'ForeignSeed' ? 'foreign_seeds.xlsx' : 'local_seeds.xlsx')
    @file = RubyXL::Parser.parse(File.join(Rails.root, 'lib', 'excels', @file_name))
    @sheet = @file[0]
  end

  def export
    type == 'ForeignSeed' ? export_foreign_seeds : export_local_seeds
    process_file
  end

  def export_local_seeds
    seeds.each_with_index do |seed, index|
      row_index = index + 1
      sheet.add_cell(row_index, 0, seed.id)
      sheet.add_cell(row_index, 1, seed.type)
      sheet.add_cell(row_index, 2, seed.seed_status)
      sheet.add_cell(row_index, 3, seed.gene_bank&.accession_number)
      sheet.add_cell(row_index, 4, 'collection_rep')
      sheet.add_cell(row_index, 5, seed.crop_name)
      sheet.add_cell(row_index, 6, seed.family)
      sheet.add_cell(row_index, 7, seed.genus)
      sheet.add_cell(row_index, 8, seed.species)
      sheet.add_cell(row_index, 9, seed.sub_texa)
      sheet.add_cell(row_index, 10, seed.seed_info&.local_name)
      sheet.add_cell(row_index, 11, seed.seed_info&.local_variety_name)
      sheet.add_cell(row_index, 12, seed.seed_info&.sample_status)
      sheet.add_cell(row_index, 13, seed.material_type)
      sheet.add_cell(row_index, 14, seed.classification)
      sheet.add_cell(row_index, 15, seed.resistant)
      sheet.add_cell(row_index, 16, seed.susceptible)
      sheet.add_cell(row_index, 17, seed.donor_info&.id)
      sheet.add_cell(row_index, 18, seed.donor_info&.donor_name)
      sheet.add_cell(row_index, 19, seed.donor_info&.house_number)
      sheet.add_cell(row_index, 20, seed.donor_info&.village)
      sheet.add_cell(row_index, 21, seed.donor_info&.dungkhag)
      sheet.add_cell(row_index, 22, seed.donor_info&.gewog)
      sheet.add_cell(row_index, 23, seed.donor_info&.dzongkhag)
      sheet.add_cell(row_index, 24, seed.donor_info&.altitude)
      sheet.add_cell(row_index, 25, seed.donor_info&.latitude)
      sheet.add_cell(row_index, 26, seed.donor_info&.longitude)
      sheet.add_cell(row_index, 27, seed.donor_info&.topography)
      sheet.add_cell(row_index, 28, seed.donor_info&.soil_color)
      sheet.add_cell(row_index, 29, seed.donor_info&.soil_texture)
      sheet.add_cell(row_index, 30, seed.collection_info&.collection_date)
      sheet.add_cell(row_index, 31, seed.collection_info&.mission_number)
      sheet.add_cell(row_index, 32, seed.collection_info&.collection_number)
      sheet.add_cell(row_index, 33, seed.collection_info&.collectors_name)
      sheet.add_cell(row_index, 34, seed.collection_info&.collection_source)
      sheet.add_cell(row_index, 35, seed.collection_info&.collection_note)
      sheet.add_cell(row_index, 36, seed.cultivation_info&.cultivation_practice)
      sheet.add_cell(row_index, 37, seed.cultivation_info&.nursery_month)
      sheet.add_cell(row_index, 38, seed.cultivation_info&.planting_month)
      sheet.add_cell(row_index, 39, seed.cultivation_info&.harvesting_month)
      sheet.add_cell(row_index, 40, seed.cultivation_info&.crop_system)
      sheet.add_cell(row_index, 41, seed.test_details.take&.germination_date)
      sheet.add_cell(row_index, 42, seed.test_details.take&.germination_rate)
      sheet.add_cell(row_index, 43, seed.test_details.take&.moisture_content)
      sheet.add_cell(row_index, 44, seed.test_details.take&.moisture_date)
      sheet.add_cell(row_index, 45, seed.test_details.take&.date_stored)
      sheet.add_cell(row_index, 46, seed.test_details.take&.remarks)
      sheet.add_cell(row_index, 47, seed.gene_bank&.packaging_date)
      sheet.add_cell(row_index, 48, seed.gene_bank&.base_collection&.germination_weight)
      sheet.add_cell(row_index, 49, seed.gene_bank&.base_collection&.germination_packets)
      sheet.add_cell(row_index, 50, seed.gene_bank&.base_collection&.regeneration_weight)
      sheet.add_cell(row_index, 51, seed.gene_bank&.base_collection&.regeneration_packets)
      sheet.add_cell(row_index, 52, seed.gene_bank&.base_collection&.rest_weight)
      sheet.add_cell(row_index, 53, seed.gene_bank&.base_collection&.rest_packets)
      sheet.add_cell(row_index, 54, seed.gene_bank&.base_collection&.locations&.first&.name)
      sheet.add_cell(row_index, 55, seed.gene_bank&.base_collection&.locations&.last&.name)
      sheet.add_cell(row_index, 56, seed.gene_bank&.active_collection&.weight)
      sheet.add_cell(row_index, 57, seed.gene_bank&.active_collection&.packets)
      sheet.add_cell(row_index, 58, seed.gene_bank&.active_collection&.location&.name)
      sheet.add_cell(row_index, 59, seed.gene_bank&.characterization&.weight)
      sheet.add_cell(row_index, 60, seed.gene_bank&.characterization&.packets)
      sheet.add_cell(row_index, 61, seed.gene_bank&.characterization&.location&.name)
      sheet.add_cell(row_index, 62, seed.gene_bank&.duplicate&.weight)
      sheet.add_cell(row_index, 63, seed.gene_bank&.duplicate&.packets)
      sheet.add_cell(row_index, 64, seed.gene_bank&.duplicate&.locations&.first&.name)
      sheet.add_cell(row_index, 65, seed.gene_bank&.duplicate&.locations&.last&.name)
      sheet.add_cell(row_index, 66, seed.gene_bank&.transfer_date)
    end
  end

  def export_foreign_seeds
    seeds.each_with_index do |seed, index|
      row_index = index + 1
      sheet.add_cell(row_index, 0, seed.id)
      sheet.add_cell(row_index, 1, seed.type)
      sheet.add_cell(row_index, 2, seed.seed_status)
      sheet.add_cell(row_index, 3, seed.gene_bank&.accession_number)
      sheet.add_cell(row_index, 4, 'collection_rep')
      sheet.add_cell(row_index, 5, seed.crop_name)
      sheet.add_cell(row_index, 6, seed.family)
      sheet.add_cell(row_index, 7, seed.genus)
      sheet.add_cell(row_index, 8, seed.species)
      sheet.add_cell(row_index, 9, seed.sub_texa)
      sheet.add_cell(row_index, 10, seed.material_type)
      sheet.add_cell(row_index, 11, seed.classification)
      sheet.add_cell(row_index, 12, seed.resistant)
      sheet.add_cell(row_index, 13, seed.susceptible)
      sheet.add_cell(row_index, 14, seed.repatriation_info&.repatriation_number)
      sheet.add_cell(row_index, 15, seed.repatriation_info&.repatriation_date)
      sheet.add_cell(row_index, 16, seed.repatriation_info&.quantity)
      sheet.add_cell(row_index, 17, seed.repatriation_info&.initial_germination_rate)
      sheet.add_cell(row_index, 18, seed.repatriation_info&.condition)
      sheet.add_cell(row_index, 19, seed.repatriation_info&.donor_accession)
      sheet.add_cell(row_index, 20, seed.repatriation_info&.donor_name)
      sheet.add_cell(row_index, 21, seed.repatriation_info&.country)
      sheet.add_cell(row_index, 22, seed.repatriation_info&.organisation)
      sheet.add_cell(row_index, 23, seed.repatriation_info&.web_url)
      sheet.add_cell(row_index, 24, seed.repatriation_info&.email_id)
      sheet.add_cell(row_index, 25, seed.repatriation_info&.phone)
      sheet.add_cell(row_index, 26, seed.repatriation_info&.fax)
      sheet.add_cell(row_index, 27, seed.repatriation_info&.remarks)
      sheet.add_cell(row_index, 28, seed.test_details.take&.germination_date)
      sheet.add_cell(row_index, 29, seed.test_details.take&.germination_rate)
      sheet.add_cell(row_index, 30, seed.test_details.take&.moisture_content)
      sheet.add_cell(row_index, 31, seed.test_details.take&.moisture_date)
      sheet.add_cell(row_index, 32, seed.test_details.take&.date_stored)
      sheet.add_cell(row_index, 33, seed.test_details.take&.remarks)
      sheet.add_cell(row_index, 34, seed.gene_bank&.packaging_date)
      sheet.add_cell(row_index, 35, seed.gene_bank&.base_collection&.germination_weight)
      sheet.add_cell(row_index, 36, seed.gene_bank&.base_collection&.germination_packets)
      sheet.add_cell(row_index, 37, seed.gene_bank&.base_collection&.regeneration_weight)
      sheet.add_cell(row_index, 38, seed.gene_bank&.base_collection&.regeneration_packets)
      sheet.add_cell(row_index, 39, seed.gene_bank&.base_collection&.rest_weight)
      sheet.add_cell(row_index, 40, seed.gene_bank&.base_collection&.rest_packets)
      sheet.add_cell(row_index, 41, seed.gene_bank&.base_collection&.locations&.first&.name)
      sheet.add_cell(row_index, 42, seed.gene_bank&.base_collection&.locations&.last&.name)
      sheet.add_cell(row_index, 43, seed.gene_bank&.active_collection&.weight)
      sheet.add_cell(row_index, 44, seed.gene_bank&.active_collection&.packets)
      sheet.add_cell(row_index, 45, seed.gene_bank&.active_collection&.location&.name)
      sheet.add_cell(row_index, 46, seed.gene_bank&.characterization&.weight)
      sheet.add_cell(row_index, 47, seed.gene_bank&.characterization&.packets)
      sheet.add_cell(row_index, 48, seed.gene_bank&.characterization&.location&.name)
      sheet.add_cell(row_index, 49, seed.gene_bank&.duplicate&.weight)
      sheet.add_cell(row_index, 50, seed.gene_bank&.duplicate&.packets)
      sheet.add_cell(row_index, 51, seed.gene_bank&.duplicate&.locations&.first&.name)
      sheet.add_cell(row_index, 52, seed.gene_bank&.duplicate&.locations&.last&.name)
      sheet.add_cell(row_index, 53, seed.gene_bank&.transfer_date)
    end
  end
end