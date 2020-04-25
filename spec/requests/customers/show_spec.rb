require 'rails_helper'

describe 'Customer', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:customer) { create(:customer) }

  it 'fetches the customer' do
    get api_v1_customer_path(customer), params: {}, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:customer, :cust_id)).to eq('CUS_01')
  end
end
