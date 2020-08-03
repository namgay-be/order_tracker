require 'rails_helper'

describe 'Dzongkhag', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }

  it 'fetches all places' do
    get api_v1_dzongkhags_path, params: {}, headers: header_params(token: token)
    expect(status).to eq(200)
  end
end
