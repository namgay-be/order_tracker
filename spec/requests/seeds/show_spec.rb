require 'rails_helper'

describe 'Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, creator: admin) }
  let!(:seed) { create(:seed, donor_info: donor_info, creator: admin) }
  let!(:collection_info) { create(:collection_info, seed: seed) }
  let!(:cultivation_info) { create(:cultivation_info, seed: seed) }
  let!(:seed_info) { create(:seed_info, seed: seed) }

  it 'fetches seed info' do
    get api_v1_seed_path(seed), params: {}, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:seed, :collection_info)).to be_present
  end
end
