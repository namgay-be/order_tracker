require 'rails_helper'

describe 'Foreign Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:foreign_seed) { create(:foreign_seed) }
  let!(:foreign_seed_info) { create(:foreign_seed_info, foreign_seed: foreign_seed) }
  let!(:repatriation_info) { create(:repatriation_info, foreign_seed: foreign_seed) }

  it 'deletes the foreign seed' do
    delete api_v1_foreign_seed_path(foreign_seed), params: {}, headers: header_params(token: token)
    expect(status).to eq(204)
    expect { ForeignSeed.find(foreign_seed.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
