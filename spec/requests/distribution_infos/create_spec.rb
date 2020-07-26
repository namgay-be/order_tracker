require 'rails_helper'

describe 'Distribution Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:customer) { create(:customer, creator: admin) }
  let!(:seed) { create(:seed, creator: admin, seed_status: :transferred) }
  let!(:gene_bank) { create(:gene_bank, seed: seed, creator: admin) }
  let!(:active_collection) { create(:active_collection, gene_bank: gene_bank) }
  let!(:base_collection) { create(:base_collection, gene_bank: gene_bank) }
  let!(:location_1) { create(:location, locatable: base_collection) }
  let!(:characterization) { create(:characterization, gene_bank: gene_bank) }
  let!(:duplicate) { create(:duplicate, gene_bank: gene_bank) }

  context 'with valid params' do
    let!(:params) do
      {
        distribution_info: {
          customer_id: customer.id,
          seed_id: seed.id,
          requested_date: 1.day.ago,
          supplied_date: 1.day.from_now,
          package_type: :duplicate,
          quantity: 11,
          purpose: 'Some purpose',
          remarks: 'Some remarks',
          locations_attributes: [
            {
              name: 'some locations'
            }
          ]
        }
      }
    end

    it 'creates a distribution info' do
      post api_v1_distribution_infos_path, params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:distribution_info, :quantity)).to eq(11)
      expect(duplicate.reload.weight).to eq(9)
      expect(duplicate.packets).to eq(20)
    end
  end

  context 'with invalid params' do
    let!(:params) do
      {
        distribution_info: {
          customer_id: customer.id,
          seed_id: seed.id,
          requested_date: 1.day.ago,
          supplied_date: 1.day.from_now,
          package_type: :duplicate,
          quantity: 31,
          purpose: 'Some purpose',
          remarks: 'Some remarks'
        }
      }
    end

    it 'throws errors' do
      post api_v1_distribution_infos_path, params: params, headers: header_params(token: token)
      expect(status).to eq(422)
      expect(json.dig(:errors, 0)).to eq('Quantity entered is more than the available amount for the packet type or the available amount is below 20g')
    end
  end
end
