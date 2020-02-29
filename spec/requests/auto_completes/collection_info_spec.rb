require 'rails_helper'

describe 'Collection Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed_1) { create(:seed) }
  let!(:collection_info) { create(:collection_info, seed: seed_1) }
  let!(:seed_2) { create(:seed) }
  let!(:collection_info_2) { create(:collection_info, collection_number: 'new_number', seed: seed_2) }
  let!(:seed_3) { create(:seed) }
  let!(:collection_info_3) { create(:collection_info, collection_number: 'new_number_2', seed: seed_3) }
  let!(:seed_4) { create(:seed) }
  let!(:collection_info_4) { create(:collection_info, collection_number: 'new_number_3', seed: seed_4) }
  let!(:seed_5) { create(:seed) }
  let!(:collection_info_5) {
    create(:collection_info, collection_number: 'new_number_4', collectors_name: 'john',
      seed: seed_5)
  }

  context 'with dynamic search queries' do
    it 'searches by collection number', number: true do
      get api_v1_collection_infos_path, params: { name: 'collection_number', query: 'new_number_3' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:collection_infos).size).to eq(1)
      expect(json.dig(:collection_infos, 0, :collection_number)).to eq(collection_info_4.collection_number)
    end

    it 'searches by collectors name', collector: true do
      get api_v1_collection_infos_path, params: { name: 'collectors_name', query: 'john' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:collection_infos).size).to eq(1)
      expect(json.dig(:collection_infos, 0, :collectors_name)).to eq(collection_info_5.collectors_name)
    end
  end
end
