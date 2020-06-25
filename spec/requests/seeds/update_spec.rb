require 'rails_helper'

describe 'Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, creator: admin) }
  let!(:seed) { create(:seed, donor_info: donor_info, creator: admin) }
  let!(:collection_info) { create(:collection_info, seed: seed) }
  let!(:donor_field_info) { create(:donor_field_info, seed: seed) }
  let!(:cultivation_info) { create(:cultivation_info, seed: seed) }
  let!(:seed_info) { create(:seed_info, seed: seed) }

  context 'with valid params' do
    let!(:params) {
      {
        seed: {
          crop_name: 'crop2',
          family: 'family2',
          genus: 'genus2',
          species: 'species2',
          sub_texa: 'sub_texa2',
          material_type: 'material2',
          classification: 'classification2',
          resistant: 'resistant2',
          susceptible: 'susceptible2',
          seed_status: 'tested',
          collection_info_attributes: {
            id: collection_info.id,
            mission_number: 'mission2',
            collection_number: 'number2',
            collection_source: 'source2',
            collectors_name: 'name2',
            collection_note: 'some note2',
            collection_date: DateTime.current
          },
          cultivation_info_attributes: {
            id: cultivation_info.id,
            nursery_month: 'nursery2',
            planting_month: 'planting2',
            harvesting_month: 'harvesting2',
            cultivation_practice: 'cultivation2',
            crop_system: 'crop2',
            characteristics: 'adomakmd madlmfasm kmakslfmd',
            requires_multiplication: true
          },
          donor_field_info_attributes: {
            id: donor_field_info.id,
            latitude: 'new asdfkj',
            longitude: 'new 23423gf',
            altitude: 'new 213sfsg',
            soil_color: 'new culture2',
            soil_texture: 'new texture2',
            topography: 'topography2',
          },
          seed_info_attributes: {
            id: seed_info.id,
            local_name: 'local2',
            local_variety_name: 'variety2',
            sample_status: 'status2'
          }
        }
      }
    }

    it 'updates the seed info' do
      put api_v1_seed_path(seed), params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seed, :collection_info)).to be_present
    end
  end
end
