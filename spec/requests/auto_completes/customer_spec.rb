require 'rails_helper'

describe 'Customer', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:customer) { create(:customer, creator: admin) }
  let!(:customer_2) { create(:customer, name: 'new name', cust_id: 'CUS_10', creator: admin) }
  let!(:customer_3) { create(:customer, name: 'different name', cust_id: 'Cus11', creator: admin) }

  context 'with dynamic search queries' do
    it 'lists customers per given query' do
      get auto_complete_api_v1_customers_path, params: { name: 'name', query: 'new'}, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:customers).size).to eq(1)
    end
  end
end
