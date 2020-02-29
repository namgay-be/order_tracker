require 'rails_helper'

describe 'Seed Info' do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed_1) { create(:seed) }
  let!(:seed_1_info) { create(:seed_info, crop_name: 'croppo', seed: seed_1) }
  let!(:seed_2) { create(:seed) }
  let!(:seed_info_2) { create(:seed_info, classification: 'something', seed: seed_2) }
  let!(:seed_3) { create(:seed) }
  let!(:seed_info_3) { create(:seed_info, local_name: 'localo', seed: seed_3) }
  let!(:seed_4) { create(:seed) }
  let!(:seed_info_4) { create(:seed_info, local_variety_name: 'varieto', seed: seed_4) }
  let!(:seed_5) { create(:seed) }
  let!(:seed_info_5) { create(:seed_info, seed_status: 'tested', seed: seed_5) }

  context 'with dynamic search queries' do
    it 'searches by crop name', crop: true do
      get api_v1_seed_infos_path, params: { name: 'crop_name', query: 'croppo' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seed_infos).size).to eq(1)
      expect(json.dig(:seed_infos, 0, :crop_name)).to eq(seed_1_info.crop_name)
    end

    it 'searches by classification name', classification: true do
      get api_v1_seed_infos_path, params: { name: 'classification', query: 'something' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seed_infos).size).to eq(1)
      expect(json.dig(:seed_infos, 0, :classification)).to eq(seed_info_2.classification)
    end
  end
end
