require 'rails_helper'

describe 'Local Seed Excel', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, creator: admin)}
  let!(:file) { fixture_file_upload(Rails.root.join('lib', 'excels', 'for_test.xlsx')) }
  let!(:params) {
    {
      seed: {
        file: file,
        name: 'cryo_seed'
      }
    }
  }

  it 'will parse the excel file and upload seeds' do
    post parse_excel_api_v1_seeds_path, params: params, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:seeds).size).to eq(2)
  end
end
