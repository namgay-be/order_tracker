require 'rails_helper'

describe 'Donor Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, donor_name: 'rooney', creator: admin) }
  let!(:seed_1) { create(:seed, donor_info: donor_info, creator: admin) }
  let!(:donor_info_2) { create(:donor_info, house_number: 'house123', creator: admin) }
  let!(:seed_2) { create(:seed, donor_info: donor_info_2, creator: admin) }
  let!(:donor_info_3) { create(:donor_info, gewog: 'thimthrom', creator: admin) }
  let!(:seed_3) { create(:seed, donor_info: donor_info_3, creator: admin) }
  let!(:donor_info_4) { create(:donor_info, dzongkhag: 'thimphu', creator: admin) }
  let!(:seed_4) { create(:seed, donor_info: donor_info_4, creator: admin) }
  let!(:donor_info_5) { create(:donor_info, donor_name: 'john', creator: admin) }
  let!(:seed_5) { create(:seed, donor_info: donor_info_5, creator: admin) }

  context 'with dynamic search queries' do
    it 'searches by donor name', donor_name: true do
      get api_v1_donor_infos_path, params: { name: 'donor_name', query: 'rooney' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:donor_infos).size).to eq(1)
      expect(json.dig(:donor_infos, 0, :donor_name)).to eq(donor_info.donor_name)
    end

    it 'searches by house number', house_number: true do
      get api_v1_donor_infos_path, params: { name: 'house_number', query: 'house123' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:donor_infos).size).to eq(1)
      expect(json.dig(:donor_infos, 0, :house_number)).to eq(donor_info_2.house_number)
    end
  end
end
