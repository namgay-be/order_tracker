class ForeignSeedExcelParser < ApplicationForm
  def run
    workbook = RubyXL::Parser.parse(params.dig(:file))
    worksheet = workbook.worksheets[0]
    seeds = []

    ForeignSeed.transaction do
      worksheet.each do |seed_data|
        next if seed_data[0]&.value == 'Family'

        seeds << create_seed(seed_data)
      end
    end
    seeds
  end

  private

  def create_seed(seed_data)
    ForeignSeed.create!(
      crop_name: seed_data[8]&.value,
      family: seed_data[0]&.value,
      genus: seed_data[1]&.value,
      species: seed_data[2]&.value,
      sub_texa: seed_data[3]&.value,
      material_type: seed_data[4]&.value,
      classification: seed_data[5]&.value,
      resistant: seed_data[6]&.value,
      susceptible: seed_data[7]&.value,
      creator_id: current_user.id,
      repatriation_info_attributes: {
        repatriation_number: seed_data[9]&.value,
        repatriation_date: seed_data[10]&.value,
        quantity: seed_data[11]&.value,
        initial_germination_rate: seed_data[12]&.value,
        condition: seed_data[13]&.value,
        donor_accession: seed_data[14]&.value,
        donor_name: seed_data[15]&.value,
        country: seed_data[16]&.value,
        organisation: seed_data[17]&.value,
        web_url: seed_data[18]&.value,
        email_id: seed_data[19]&.value,
        phone: seed_data[20]&.value,
        fax: seed_data[21]&.value,
        remarks: seed_data[22]&.value
      }
    )
  end
end
