require 'rails_helper'

describe 'Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:donor_info) { create(:donor_info, creator: admin) }
  let!(:seed_1) { create(
    :seed,
    crop_name: 'croppo',
    requires_multiplication: true,
    donor_info: donor_info,
    creator: admin
    )
  }
  let!(:collection_info) { create(:collection_info, seed: seed_1) }
  let!(:donor_field_info) { create(:donor_field_info, seed: seed_1) }
  let!(:cultivation_info) { create(:cultivation_info, seed: seed_1) }
  let!(:seed_1_info) { create(:seed_info, seed: seed_1) }

  let!(:donor_info_2) { create(:donor_info, creator: admin) }
  let!(:seed_2) { create(
    :seed,
    classification: 'something',
    created_at: 2.days.from_now,
    donor_info: donor_info_2,
    creator: admin
    )
  }
  let!(:collection_info_2) { create(:collection_info, collection_number: 'new_number', seed: seed_2) }
  let!(:donor_field_info_2) { create(:donor_field_info, seed: seed_2, altitude: 22.3) }
  let!(:cultivation_info_2) { create(:cultivation_info, seed: seed_2) }
  let!(:seed_info_2) { create(:seed_info, seed: seed_2) }

  let!(:donor_info_3) { create(:donor_info, gewog: 'thimthrom', creator: admin) }
  let!(:seed_3) { create(:seed, donor_info: donor_info_3, creator: admin) }
  let!(:collection_info_3) { create(:collection_info, collection_number: 'new_number_2', seed: seed_3) }
  let!(:donor_field_info_3) { create(:donor_field_info, seed: seed_3) }
  let!(:cultivation_info_3) { create(:cultivation_info, seed: seed_3) }
  let!(:seed_info_3) { create(:seed_info, local_name: 'localo', seed: seed_3) }

  let!(:donor_info_4) { create(:donor_info, dzongkhag: 'thimphu', creator: admin) }
  let!(:seed_4) { create(:seed, donor_info: donor_info_4, creator: admin) }
  let!(:collection_info_4) { create(:collection_info, collection_number: 'new_number_3', seed: seed_4) }
  let!(:donor_field_info_4) { create(:donor_field_info, seed: seed_4) }
  let!(:cultivation_info_4) { create(:cultivation_info, seed: seed_4) }
  let!(:seed_info_4) { create(:seed_info, local_variety_name: 'varieto', seed: seed_4) }

  let!(:donor_info_5) { create(:donor_info, donor_name: 'john', creator: admin) }
  let!(:seed_5) { create(:seed, seed_status: 'tested', donor_info: donor_info_5, creator: admin) }
  let!(:collection_info_5) { create(:collection_info, collection_number: 'new_number_4', seed: seed_5) }
  let!(:donor_field_info_5) { create(:donor_field_info, seed: seed_5) }
  let!(:cultivation_info_5) { create(:cultivation_info, seed: seed_5) }
  let!(:seed_info_5) { create(:seed_info, seed: seed_5) }

  let!(:seed_6) { create(:foreign_seed, creator: admin) }
  let!(:repatriation_info) { create(:repatriation_info, foreign_seed: seed_6, repatriation_number: '101') }

  let!(:seed_7) { create(:foreign_seed, creator: admin) }
  let!(:repatriation_info_2) { create(:repatriation_info, foreign_seed: seed_7, donor_name: 'namgay') }

  context 'with filters' do
    it 'filters by seed status', status: true do
      get list_api_v1_seeds_path, params: { status: 'under_process' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(6)
    end

    it 'filters by duration', duration: true do
      get list_api_v1_seeds_path, params: { duration: 'current_month' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(7)
    end
  end
end
