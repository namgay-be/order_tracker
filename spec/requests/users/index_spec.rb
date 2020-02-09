require 'rails_helper'

describe 'User', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:moderator) { create(:user, role_id: Role.second.id) }
  let!(:moderator_2) { create(:user, role_id: Role.second.id, name: 'namgay') }

  it 'Lists all users' do
    get api_v1_users_path, params: { role_filter: 'admin' }, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:users).size).to eq(1)
  end

  it 'Queries a user' do
    get api_v1_users_path, params: { query: 'namgay' }, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:users).size).to eq(1)
    expect(json.dig(:users, 0, :id)).to eq(moderator_2.id)
  end
end
