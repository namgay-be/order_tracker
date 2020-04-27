require 'rails_helper'

describe 'Distribution Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:customer) { create(:customer) }
  let!(:seed) { create(:seed) }
  let!(:gene_bank) { create(:gene_bank, seed: seed) }
  let!(:active_collection) { create(:active_collection, gene_bank: gene_bank) }
  let!(:base_collection) { create(:base_collection, gene_bank: gene_bank) }
  let!(:location_1) { create(:location, locatable: base_collection) }
  let!(:characterization) { create(:characterization, gene_bank: gene_bank) }
  let!(:duplicate) { create(:duplicate, gene_bank: gene_bank) }
  let!(:distribution_info) { create(:distribution_info, customer: customer, seed: seed) }

  context 'with valid params' do
    let!(:params) do
      {
        distribution_info: {
          requested_date: 3.days.ago,
          supplied_date: 3.days.from_now,
          package_type: :duplicate,
          quantity: 15,
          purpose: 'Some purpose',
          remarks: 'Some remarks'
        }
      }
    end

    it 'updates a distribution info' do
      put api_v1_distribution_info_path(distribution_info), params: params, headers: header_params(token: token)
      expect(status).to eq(200)
    end
  end
end