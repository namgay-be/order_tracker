require 'rails_helper'

describe 'Customer', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:customer) { create(:customer, creator: admin) }

  it 'deletes the customer' do
    delete api_v1_customer_path(customer), params: {}, headers: header_params(token: token)
    expect(status).to eq(204)
    expect { Customer.find(customer.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
