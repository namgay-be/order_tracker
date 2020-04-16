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

  context 'with valid params' do
    let!(:params) do
      {
        test_detail: {
          seed_id: seed.id,
          germination_rate: 10.0,
          germination_date: DateTime.current,
          moisture_content: 30.4,
          moisture_date: DateTime.current + 2.day,
          remarks: 'Some remarks',
          date_stored: DateTime.current
        }
      }
    end

    it 'creates a test detail' do
      post api_v1_test_details_path, params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:test_detail, :germination_rate).to_f).to eq(TestDetail.first.germination_rate.to_f)
    end
  end
end
