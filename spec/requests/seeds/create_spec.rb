require 'rails_helper'

describe 'Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, creator: admin)}

  context 'with valid params' do
    let!(:params) {
      {
        seed: {
          crop_name: 'crop1',
          family: 'family1',
          genus: 'genus1',
          species: 'species1',
          sub_texa: 'sub_texa1',
          material_type: 'material1',
          classification: 'classification1',
          resistant: 'resistant1',
          susceptible: 'susceptible1',
          seed_status: 'under_process',
          donor_info_id: donor_info.id,
          collection_info_attributes: {
            mission_number: 'mission1',
            collection_number: 'number1',
            collection_source: 'source1',
            collectors_name: 'name1',
            collection_note: 'some note1',
            collection_date: DateTime.current
          },
          cultivation_info_attributes: {
            nursery_month: 'nursery1',
            planting_month: 'planting1',
            harvesting_month: 'harvesting1',
            cultivation_practice: 'cultivation1',
            crop_system: 'crop1',
            characteristics: 'adomakmd madlmfasm kmakslfmd',
            requires_multiplication: true
          },
          seed_info_attributes: {
            local_name: 'local1',
            local_variety_name: 'variety1',
            sample_status: 'status1'
          }
        }
      }
    }

    it 'creates the seed info' do
      post api_v1_seeds_path, params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seed, :collection_info)).to be_present
    end
  end
end
