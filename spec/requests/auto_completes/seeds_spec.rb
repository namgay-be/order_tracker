require 'rails_helper'

describe 'Seed' do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed_1) { create(:seed, crop_name: 'croppo') }
  let!(:seed_2) { create(:seed, classification: 'something') }
  let!(:seed_5) { create(:seed, seed_status: 'tested') }

  context 'with dynamic search queries' do
    it 'searches by crop name', crop: true do
      get auto_complete_api_v1_seeds_path, params: { name: 'crop_name', query: 'croppo' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :crop_name)).to eq(seed_1.crop_name)
    end

    it 'searches by classification name', classification: true do
      get auto_complete_api_v1_seeds_path, params: { name: 'classification', query: 'something' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :classification)).to eq(seed_2.classification)
    end
  end
end
