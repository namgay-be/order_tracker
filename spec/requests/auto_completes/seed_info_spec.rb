require 'rails_helper'

describe 'Seed Info' do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed_3) { create(:seed) }
  let!(:seed_info_3) { create(:seed_info, local_name: 'localo', seed: seed_3) }
  let!(:seed_4) { create(:seed) }
  let!(:seed_info_4) { create(:seed_info, local_variety_name: 'varieto', seed: seed_4) }

  context 'with dynamic search queries' do
    it 'searches by crop name', crop: true do
      get api_v1_seed_infos_path, params: {name: 'local_name', query: 'localo'}, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seed_infos).size).to eq(1)
      expect(json.dig(:seed_infos, 0, :local_name)).to eq(seed_info_3.local_name)
    end

    it 'searches by classification name', classification: true do
      get api_v1_seed_infos_path, params: {name: 'local_variety_name', query: 'varieto'}, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seed_infos).size).to eq(1)
      expect(json.dig(:seed_infos, 0, :local_variety_name)).to eq(seed_info_4.local_variety_name)
    end
  end
end
