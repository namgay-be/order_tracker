require 'rails_helper'

describe 'User', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:moderator) { create(:user, role_id: Role.second.id) }

  it 'fetches the user' do
    get api_v1_user_path(moderator), params: {}, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:user, :email)).to eq(moderator.email)
  end
end
