require 'rails_helper'

describe 'User', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:moderator) { create(:user, role_id: Role.second.id) }

  let!(:params) {
    {
      user: {
        name: 'something',
        image: image_upload,
        email: 'new@dcpl.bt'
      }
    }
  }

  it 'updates a user' do
    put api_v1_user_path(admin), params: params, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:user, :email)).to eq('new@dcpl.bt')
  end
end
