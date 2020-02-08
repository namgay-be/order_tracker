require 'rails_helper'

describe 'User', type: :request do
  let!(:cto) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(cto) }
  let!(:senior) { create(:user, role_id: Role.third.id) }
  let!(:junior) { create(:user, role_id: Role.fourth.id, email: 'namgay@dcpl.bt') }

  it 'Lists all users' do
    get api_v1_users_path, params: { role_filter: 'CTO' }, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:users).size).to eq(1)
  end

  it 'Queries a user' do
    get api_v1_users_path, params: { query: 'namgay' }, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:users).size).to eq(1)
    expect(json.dig(:users, 0, :id)).to eq(junior.id)
  end
end
