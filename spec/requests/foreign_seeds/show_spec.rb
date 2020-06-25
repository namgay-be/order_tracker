require 'rails_helper'

describe 'Foreign Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:foreign_seed) { create(:foreign_seed, creator: admin) }
  let!(:repatriation_info) { create(:repatriation_info, foreign_seed: foreign_seed) }

  it 'fetches the foreign seed' do
    get api_v1_foreign_seed_path(foreign_seed), params: {}, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:foreign_seed, :repatriation_info)).to be_present
  end
end
