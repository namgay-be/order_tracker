require 'rails_helper'

describe 'Test Details', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, creator: admin) }
  let!(:seed) { create(:seed, donor_info: donor_info, creator: admin) }
  let!(:collection_info) { create(:collection_info, seed: seed) }
  let!(:donor_field_info) { create(:donor_field_info, seed: seed) }
  let!(:cultivation_info) { create(:cultivation_info, seed: seed) }
  let!(:seed_info) { create(:seed_info, seed: seed) }
  let!(:test_detail) { create(:test_detail, seed: seed, creator: admin) }

  it 'fetches a test detail' do
    get api_v1_test_detail_path(test_detail), params: {}, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:test_detail, :germination_rate).to_f).to eq(test_detail.germination_rate.to_f)
  end
end
