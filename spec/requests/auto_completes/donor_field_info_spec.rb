require 'rails_helper'

describe 'Donor Field Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed_1) { create(:seed, creator: admin) }
  let!(:donor_field_info) { create(:donor_field_info, soil_color: 'normal', seed: seed_1) }
  let!(:seed_2) { create(:seed, creator: admin) }
  let!(:donor_field_info_2) { create(:donor_field_info, soil_texture: 'texture2', seed: seed_2) }
  let!(:seed_3) { create(:seed, creator: admin) }
  let!(:donor_field_info_3) { create(:donor_field_info, seed: seed_3) }
  let!(:seed_4) { create(:seed, creator: admin) }
  let!(:donor_field_info_4) { create(:donor_field_info, seed: seed_4) }
  let!(:seed_5) { create(:seed, creator: admin) }
  let!(:donor_field_info_5) { create(:donor_field_info, seed: seed_5) }

  context 'with dynamic search queries' do
    it 'searches by soil culture', soil_color: true do
      get api_v1_donor_field_infos_path, params: { name: 'soil_color', query: 'normal' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:donor_field_infos).size).to eq(1)
      expect(json.dig(:donor_field_infos, 0, :soil_color)).to eq(donor_field_info.soil_color)
    end

    it 'searches by soil texture', soil_texture: true do
      get api_v1_donor_field_infos_path, params: { name: 'soil_texture', query: 'texture2' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:donor_field_infos).size).to eq(1)
      expect(json.dig(:donor_field_infos, 0, :soil_texture)).to eq(donor_field_info_2.soil_texture)
    end
  end
end
