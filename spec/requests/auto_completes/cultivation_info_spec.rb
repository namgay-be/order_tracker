require 'rails_helper'

describe 'Cultivation Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed_1) { create(:seed) }
  let!(:cultivation_info) { create(:cultivation_info, nursery_month: 'jan', seed: seed_1) }
  let!(:seed_2) { create(:seed) }
  let!(:cultivation_info_2) { create(:cultivation_info, seed: seed_2) }
  let!(:seed_3) { create(:seed) }
  let!(:cultivation_info_3) { create(:cultivation_info, seed: seed_3) }
  let!(:seed_4) { create(:seed) }
  let!(:cultivation_info_4) { create(:cultivation_info, seed: seed_4) }
  let!(:seed_5) { create(:seed) }
  let!(:cultivation_info_5) { create(:cultivation_info, cultivation_practice: 'normal', seed: seed_5) }

  context 'with dynamic search queries' do
    it 'searches by nursery month', nursery: true do
      get api_v1_cultivation_infos_path, params: { name: 'nursery_month', query: 'jan' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:cultivation_infos).size).to eq(1)
      expect(json.dig(:cultivation_infos, 0, :nursery_month)).to eq(cultivation_info.nursery_month)
    end

    it 'searches by cultivation practice', cultivation: true do
      get api_v1_cultivation_infos_path, params: { name: 'cultivation_practice', query: 'normal' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:cultivation_infos).size).to eq(1)
      expect(json.dig(:cultivation_infos, 0, :cultivation_practice)).to eq(cultivation_info_5.cultivation_practice)
    end
  end
end
