require 'rails_helper'

describe 'Customer', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:customer) { create(:customer) }

  context 'with valid params' do
    let!(:params) do
      {
        customer: {
          name: 'Mbis',
          designation: 'engineer',
          organisation: 'DragonCoders',
          status: 'Some status',
          address: 'Taba'
        }
      }
    end

    it 'updates a customer' do
      put api_v1_customer_path(customer), params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:customer, :name)).to eq('Mbis')
    end
  end
end
