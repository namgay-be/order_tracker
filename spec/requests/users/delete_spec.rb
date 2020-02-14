require 'rails_helper'

describe 'User', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:moderator) { create(:user, role_id: Role.second.id) }

  let!(:params) {
    {
      user: {
        deleted_at: DateTime.current
      }
    }
  }

  it 'deletes the user' do
    put soft_delete_api_v1_user_path(moderator), params: params, headers: header_params(token: token)
    expect(status).to eq(200)
  end
end
