require 'rails_helper'

describe 'Donor Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:params) do
    {
      donor_info: {
        donor_name: 'donor1',
        house_number: 'house1',
        dzongkhag: 'thimphu1',
        gewog: 'gewog1',
        dungkhag: 'dungkhag1',
        village: 'village1'
      }
    }
  end

  it 'creates a donor info record' do
    post api_v1_donor_infos_path, params: params, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:donor_info, :donor_name)).to eq('donor1')
  end
end
