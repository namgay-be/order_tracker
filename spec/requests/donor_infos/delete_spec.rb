require 'rails_helper'

describe 'Donor Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, creator: admin) }

  it 'deletes a donor info record' do
    delete api_v1_donor_info_path(donor_info), params: {}, headers: header_params(token: token)
    expect(status).to eq(204)
    expect { DonorInfo.find(donor_info.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
