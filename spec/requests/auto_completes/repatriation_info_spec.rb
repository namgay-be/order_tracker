require 'rails_helper'

describe 'Seed Info' do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed_1) { create(:foreign_seed, creator: admin) }
  let!(:repatriation_info_1) { create(:repatriation_info, repatriation_number: 'abc123', foreign_seed: seed_1) }
  let!(:seed_2) { create(:foreign_seed, creator: admin) }
  let!(:repatriation_info_2) { create(:repatriation_info, organisation: 'Selise', foreign_seed: seed_2) }

  context 'with dynamic search queries' do
    it 'searches by repatriation number' do
      get api_v1_repatriation_infos_path, params: {name: 'repatriation_number', query: 'abc123'}, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:repatriation_infos).size).to eq(1)
      expect(json.dig(:repatriation_infos, 0, :repatriation_number)).to eq(repatriation_info_1.repatriation_number)
    end

    it 'searches by organisation' do
      get api_v1_repatriation_infos_path, params: {name: 'organisation', query: 'Selise'}, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:repatriation_infos).size).to eq(1)
      expect(json.dig(:repatriation_infos, 0, :organisation)).to eq(repatriation_info_2.organisation)
    end
  end
end
