require 'rails_helper'

describe 'Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, creator: admin) }
  let!(:seed) { create(:seed, donor_info: donor_info, creator: admin) }
  let!(:collection_info) { create(:collection_info, seed: seed) }
  let!(:cultivation_info) { create(:cultivation_info, seed: seed) }
  let!(:seed_info) { create(:seed_info, seed: seed) }

  let!(:donor_info_2) { create(:donor_info, creator: admin) }
  let!(:seed_2) { create(
    :seed,
    classification: 'something',
    created_at: 2.days.from_now,
    donor_info: donor_info_2,
    creator: admin
  )
  }
  let!(:collection_info_2) { create(:collection_info, collection_number: 'new_number', seed: seed_2) }
  let!(:cultivation_info_2) { create(:cultivation_info, seed: seed_2) }
  let!(:seed_info_2) { create(:seed_info, seed: seed_2) }

  it 'deletes seed info' do
    delete api_v1_seed_path(seed), params: {}, headers: header_params(token: token)
    expect(status).to eq(204)
    expect { Seed.find(seed.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'deletes seed infos in bulk' do
    delete batch_delete_api_v1_seeds_path, params: { seed_ids: [seed.id, seed_2.id]}, headers: header_params(token: token)
    expect(status).to eq(204)
    expect(Seed.count).to eq(0)
  end

  it 'disqualifies a seed' do
    delete disqualify_api_v1_seed_path(seed), params: {}, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig('seed', 'seed_status')).to eq('rejected')
  end
end
