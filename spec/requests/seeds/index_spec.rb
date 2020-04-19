require 'rails_helper'

describe 'Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed_1) { create(:seed, crop_name: 'croppo', requires_multiplication: true) }
  let!(:collection_info) { create(:collection_info, seed: seed_1) }
  let!(:donor_field_info) { create(:donor_field_info, seed: seed_1) }
  let!(:cultivation_info) { create(:cultivation_info, seed: seed_1) }
  let!(:donor_info) { create(:donor_info, seed: seed_1) }
  let!(:seed_1_info) { create(:seed_info, seed: seed_1) }

  let!(:seed_2) { create(:seed, classification: 'something') }
  let!(:collection_info_2) { create(:collection_info, collection_number: 'new_number', seed: seed_2) }
  let!(:donor_field_info_2) { create(:donor_field_info, seed: seed_2, altitude: 22.3) }
  let!(:cultivation_info_2) { create(:cultivation_info, seed: seed_2) }
  let!(:donor_info_2) { create(:donor_info, seed: seed_2) }
  let!(:seed_info_2) { create(:seed_info, seed: seed_2) }

  let!(:seed_3) { create(:seed) }
  let!(:collection_info_3) { create(:collection_info, collection_number: 'new_number_2', seed: seed_3) }
  let!(:donor_field_info_3) { create(:donor_field_info, seed: seed_3) }
  let!(:cultivation_info_3) { create(:cultivation_info, seed: seed_3) }
  let!(:donor_info_3) { create(:donor_info, gewog: 'thimthrom', seed: seed_3) }
  let!(:seed_info_3) { create(:seed_info, local_name: 'localo', seed: seed_3) }

  let!(:seed_4) { create(:seed) }
  let!(:collection_info_4) { create(:collection_info, collection_number: 'new_number_3', seed: seed_4) }
  let!(:donor_field_info_4) { create(:donor_field_info, seed: seed_4) }
  let!(:cultivation_info_4) { create(:cultivation_info, seed: seed_4) }
  let!(:donor_info_4) { create(:donor_info, dzongkhag: 'thimphu', seed: seed_4) }
  let!(:seed_info_4) { create(:seed_info, local_variety_name: 'varieto', seed: seed_4) }

  let!(:seed_5) { create(:seed, seed_status: 'tested') }
  let!(:collection_info_5) { create(:collection_info, collection_number: 'new_number_4', seed: seed_5) }
  let!(:donor_field_info_5) { create(:donor_field_info, seed: seed_5) }
  let!(:cultivation_info_5) { create(:cultivation_info, seed: seed_5) }
  let!(:donor_info_5) { create(:donor_info, donor_name: 'john', seed: seed_5) }
  let!(:seed_info_5) { create(:seed_info, seed: seed_5) }

  context 'with search queries' do
    it 'fetches seed info with crop name' do
      get api_v1_seeds_path, params: { query: 'croppo' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :crop_name)).to eq(seed_1.crop_name)
    end

    it 'fetches seed info with collection number' do
      get api_v1_seeds_path, params: { query: 'new_number' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(4)
    end
  end

  context 'with filters' do
    it 'filters by crop name', crop: true do
      get api_v1_seeds_path, params: { crop_name: 'croppo' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :crop_name)).to eq(seed_1.crop_name)
    end

    it 'filters by local name', local: true do
      get api_v1_seeds_path, params: { local_name: 'localo' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :seed_info, :local_name)).to eq(seed_info_3.local_name)
    end

    it 'filters by local variety name', local_variety: true do
      get api_v1_seeds_path, params: { local_variety: 'varieto' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :seed_info, :local_variety_name)).to eq(seed_info_4.local_variety_name)
    end

    it 'filters by seed status', status: true do
      get api_v1_seeds_path, params: { status: 'tested' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :seed_status)).to eq(seed_5.seed_status)
    end

    it 'filters by seed classification', classification: true do
      get api_v1_seeds_path, params: { classification: 'something' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :classification)).to eq(seed_2.classification)
    end

    it 'filters by donor name', donor: true do
      get api_v1_seeds_path, params: { donor: 'john' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :donor_info, :donor_name)).to eq(donor_info_5.donor_name)
    end

    it 'filters by dzongkhag', dzongkhag: true do
      get api_v1_seeds_path, params: { dzongkhag: 'thimphu' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :donor_info, :dzongkhag)).to eq(donor_info_4.dzongkhag)
    end

    it 'filters by gewog', gewog: true do
      get api_v1_seeds_path, params: { gewog: 'thimthrom' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :donor_info, :gewog)).to eq(donor_info_3.gewog)
    end

    it 'filters by type of seed', seed_type: true do
      get api_v1_seeds_path, params: { type: 'ForeignSeed' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(0)
    end

    it 'filters by maximum altitude', maximum_altitude: true do
      get api_v1_seeds_path, params: { maximum_altitude: 50.05 }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
      expect(json.dig(:seeds, 0, :id)).to eq(seed_2.id)
    end

    it 'filters by minimum altitude', minimum_altitude: true do
      get api_v1_seeds_path, params: { minimum_altitude: 50.05 }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(4)
    end

    it 'filters by requires multiplication flag', requires_multiplication: true do
      get api_v1_seeds_path, params: { requires_multiplication: true }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:seeds).size).to eq(1)
    end
  end
end
