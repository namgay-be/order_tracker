require 'rails_helper'

describe 'Test Details', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed) { create(:seed) }
  let!(:collection_info) { create(:collection_info, seed: seed) }
  let!(:donor_field_info) { create(:donor_field_info, seed: seed) }
  let!(:cultivation_info) { create(:cultivation_info, seed: seed) }
  let!(:donor_info) { create(:donor_info, seed: seed) }
  let!(:seed_info) { create(:seed_info, seed: seed) }
  let!(:test_detail) { create(:test_detail, seed: seed) }

  context 'with valid params' do
    let!(:params) do
      {
        test_detail: {
          germination_rate: 14.23,
          germination_date: DateTime.current + 1.day,
          moisture_content: 70.45,
          moisture_date: DateTime.current + 1.day,
          remarks: 'Some new remarks',
          date_stored: DateTime.current
        }
      }
    end

    it 'updates a test detail' do
      put api_v1_test_detail_path(test_detail), params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:test_detail, :germination_rate).to_f).to eq(test_detail.reload.germination_rate.to_f)
    end
  end
end
