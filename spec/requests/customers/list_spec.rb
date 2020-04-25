require 'rails_helper'

describe 'Customer', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:customer) { create(:customer) }
  let!(:customer_2) { create(:customer, name: 'new name', cust_id: 'CUS_10') }
  let!(:customer_3) { create(:customer, name: 'different name', cust_id: 'Cus11') }

  context 'without search filters' do
    it 'lists all customers' do
      get api_v1_customers_path, params: {}, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:customers).size).to eq(3)
    end
  end

  context 'with search filters' do
    it 'lists all customers' do
      get api_v1_customers_path, params: { query: 'CUS_10'}, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:customers).size).to eq(1)
    end
  end
end
