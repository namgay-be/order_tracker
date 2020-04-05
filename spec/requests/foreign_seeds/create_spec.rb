require 'rails_helper'

describe 'Foreign Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }

  context 'with valid params' do
    let!(:params) {
      {
        foreign_seed: {
          foreign_seed_info_attributes: {
            crop_name: 'something',
            genus: 'some genus',
            family: 'some family',
            species: 'some species',
            sub_texa: 'some sub',
            material_type: 'some material type',
            classification: 'some classification',
            characteristics: 'some characteristics'
          },
          repatriation_info_attributes: {
            repatriation_number: 'some number',
            repatriation_date: DateTime.current,
            quantity: 1,
            initial_germination_rate: 12,
            resistant: 'some resistant',
            susceptible: 'some susceptible',
            condition: 'some condition',
            donor_accession: 'some donor accession',
            donor_name: 'some donor name',
            country: 'india',
            organisation: 'some organisation',
            web_url: 'some web url',
            email_id: 'some email id',
            phone: 'some phone',
            fax: 'some fax',
            remarks: 'some remarks'
          }
        }
      }
    }

    it 'creates the foreign seed' do
      post api_v1_foreign_seeds_path, params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:foreign_seed, :repatriation_info)).to be_present
    end
  end
end