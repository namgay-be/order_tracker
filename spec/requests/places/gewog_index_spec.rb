require 'rails_helper'

describe 'Gewog', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }

  it 'fetches all gewogs' do
    get api_v1_gewogs_path, params: { dzongkhag_id: 1 }, headers: header_params(token: token)
    expect(status).to eq(200)
  end
end
