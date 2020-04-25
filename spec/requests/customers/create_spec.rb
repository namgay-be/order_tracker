require 'rails_helper'

describe 'Customer', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }

  context 'with valid params' do
    let!(:params) do
      {
        customer: {
          name: 'Gbis',
          designation: 'engineer',
          organisation: 'DragonCoders',
          status: 'Some status',
          address: 'Chubachu'
        }
      }
    end

    it 'creates a customer' do
      post api_v1_customers_path, params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:customer, :cust_id)).to eq(Customer.first.cust_id)
    end
  end
end
