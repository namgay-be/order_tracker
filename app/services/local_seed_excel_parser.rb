class LocalSeedExcelParser < ApplicationForm
  attr_accessor :seed_type

  def run
    workbook = RubyXL::Parser.parse(params.dig(:file))
    worksheet = workbook.worksheets[0]
    seeds = []

    Seed.transaction do
      worksheet.each do |seed_data|
        next if seed_data[0]&.value == 'Family'

        donor = DonorInfo.find_by(custom_donor_id: seed_data[10]&.value) || create_donor(seed_data)
        seeds << create_seed(donor, seed_data)
      end
    end
    seeds
  end

  private

  def create_seed(donor, seed_data)
    Seed.create!(
      type: seed_type,
      crop_name: seed_data[8]&.value,
      family: seed_data[0]&.value,
      genus: seed_data[1]&.value,
      species: seed_data[2]&.value,
      sub_texa: seed_data[3]&.value,
      material_type: seed_data[4]&.value,
      classification: seed_data[5]&.value,
      resistant: seed_data[6]&.value,
      susceptible: seed_data[7]&.value,
      donor_info_id: donor.id,
      creator_id: current_user.id,
      collection_info_attributes: {
        mission_number: seed_data[23]&.value,
        collection_number: seed_data[24]&.value,
        collection_source: seed_data[25]&.value,
        collectors_name: seed_data[26]&.value,
        collection_note: seed_data[27]&.value,
        collection_date: seed_data[28]&.value
      },
      cultivation_info_attributes: {
        nursery_month: seed_data[29]&.value,
        planting_month: seed_data[30]&.value,
        harvesting_month: seed_data[31]&.value,
        cultivation_practice: seed_data[32]&.value,
        crop_system: seed_data[33]&.value,
        characteristics: seed_data[34]&.value,
      },
      seed_info_attributes: {
        local_name: seed_data[35]&.value,
        local_variety_name: seed_data[36]&.value,
        sample_status: seed_data[37]&.value
      }
    )
  end

  def create_donor(seed_data)
    DonorInfo.create!(
      donor_name: seed_data[11]&.value,
      house_number: seed_data[12]&.value,
      dzongkhag: seed_data[13]&.value,
      gewog: seed_data[14]&.value,
      dungkhag: seed_data[15]&.value,
      village: seed_data[16]&.value,
      latitude: seed_data[17]&.value,
      longitude: seed_data[18]&.value,
      altitude: seed_data[19]&.value,
      soil_color: seed_data[20]&.value,
      soil_texture: seed_data[21]&.value,
      topography: seed_data[22]&.value,
      creator_id: current_user.id,
    )
  end
end
