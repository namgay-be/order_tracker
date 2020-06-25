require 'rails_helper'

describe 'GeneBank', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed) { create(:seed, creator: admin) }
  let!(:gene_bank) { create(:gene_bank, seed: seed, creator: admin) }
  let!(:active_collection) { create(:active_collection, gene_bank: gene_bank) }
  let!(:base_collection) { create(:base_collection, gene_bank: gene_bank) }
  let!(:location_1) { create(:location, locatable: base_collection) }
  let!(:characterization) { create(:characterization, gene_bank: gene_bank) }
  let!(:duplicate) { create(:duplicate, gene_bank: gene_bank) }

  context 'with valid params' do
    let!(:params) {
      {
        gene_bank: {
          packaging_date: DateTime.current + 3.hours,
          base_collection_attributes: {
            id: base_collection.id,
            germination_weight: 33.7,
            germination_packets: 22,
            regeneration_weight: 22.7,
            regeneration_packets: 33,
            rest_weight: 11.7,
            rest_packets: 11,
            locations_attributes: [
              {
                id: location_1.id,
                name: 'Thimphu'
              }
            ]
          },
          active_collection_attributes: {
            weight: 77.4,
            packets: 33
          },
          characterization_attributes: {
            weight: 29.9,
            packets: 55
          },
          duplicate_attributes: {
            weight: 88.4,
            packets: 50
          }
        }
      }
    }

    it 'updates a gene bank record' do
      put api_v1_gene_bank_path(gene_bank), params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:gene_bank, :base_collection)).to be_present
      expect(json.dig(:gene_bank, :active_collection)).to be_present
      expect(json.dig(:gene_bank, :characterization)).to be_present
      expect(json.dig(:gene_bank, :duplicate)).to be_present
    end
  end
end