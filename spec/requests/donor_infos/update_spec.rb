require 'rails_helper'

describe 'Donor Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, creator: admin)}
  let!(:params) do
    {
      donor_info: {
        donor_name: 'donor2',
        house_number: 'house1',
        dungkhag: 'dungkhag1',
        village: 'village1'
      }
    }
  end

  it 'updates a donor info record' do
    put api_v1_donor_info_path(donor_info), params: params, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:donor_info, :donor_name)).to eq('donor2')
  end
end
