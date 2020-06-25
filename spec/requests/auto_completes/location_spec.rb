require 'rails_helper'

describe 'Location' do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed) { create(:seed, creator: admin) }
  let!(:gene_bank) { create(:gene_bank, seed: seed, creator: admin) }
  let!(:active_collection) { create(:active_collection, gene_bank: gene_bank) }
  let!(:base_collection) { create(:base_collection, gene_bank: gene_bank) }
  let!(:location_1) { create(:location, locatable: base_collection) }
  let!(:location_2) { create(:location, locatable: active_collection, name: 'Non') }

  context 'with dynamic search queries' do
    it 'searches by name' do
      get api_v1_locations_path, params: {name: 'name', query: 'Non'}, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:locations).size).to eq(1)
      expect(json.dig(:locations, 0, :name)).to eq(location_2.name)
    end
  end
end
