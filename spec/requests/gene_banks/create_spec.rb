require 'rails_helper'

describe 'GeneBank', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed) { create(:seed, seed_status: :tested) }

  context 'with valid params' do
    let!(:params) {
      {
        gene_bank: {
          seed_id: seed.id,
          packaging_date: DateTime.current,
          base_collection_attributes: {
            germination_weight: 33.7,
            germination_packets: 22,
            regeneration_weight: 22.7,
            regeneration_packets: 33,
            rest_weight: 11.7,
            rest_packets: 11,
            locations_attributes: [
              {
                name: 'Thimphu'
              },
              {
                name: 'Paro'
              }
            ]
          },
          active_collection_attributes: {
            weight: 77.4,
            packets: 33,
            location_attributes: {name: 'Phuenthsoling'}
          },
          characterization_attributes: {
            weight: 29.9,
            packets: 55,
            location_attributes: {name: 'Dechencholing'}
          },
          duplicate_attributes: {
            weight: 88.4,
            packets: 50,
            locations_attributes: [
              {
                name: 'Babesa'
              },
              {
                name: 'Kalikhola'
              }
            ]
          }
        }
      }
    }

    it 'creates a gene bank record' do
      post api_v1_gene_banks_path, params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:gene_bank, :accession_number)).to be_present
      expect(json.dig(:gene_bank, :base_collection)).to be_present
      expect(json.dig(:gene_bank, :active_collection)).to be_present
      expect(json.dig(:gene_bank, :characterization)).to be_present
      expect(json.dig(:gene_bank, :duplicate)).to be_present

      expect(PacketCount.count).to eq(1)
    end
  end
end
