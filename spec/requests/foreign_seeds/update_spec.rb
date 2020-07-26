require 'rails_helper'

describe 'Foreign Seed', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:foreign_seed) { create(:foreign_seed, creator: admin) }
  let!(:repatriation_info) { create(:repatriation_info, foreign_seed: foreign_seed) }

  context 'with valid params' do
    let!(:params) {
      {
        foreign_seed: {
          crop_name: 'something',
          genus: 'some genus',
          family: 'some family',
          species: 'some species',
          sub_texa: 'some sub',
          resistant: 'some resistant',
          susceptible: 'some susceptible',
          material_type: 'some material type',
          classification: 'some classification',
          characteristics: 'some characteristics',
          repatriation_info_attributes: {
            id: repatriation_info.id,
            repatriation_number: 'some number',
            repatriation_date: DateTime.current,
            quantity: 1,
            initial_germination_rate: 12,
            condition: 'some condition',
            donor_accession: 'some donor accession',
            donor_name: 'some donor name',
            country: 'india',
            organisation: 'some organisation',
            web_url: 'some web url',
            email_id: 'namgay@gmail.com',
            phone: 'some phone',
            fax: 'some fax',
            remarks: 'some remarks'
          }
        }
      }
    }

    it 'updates the foreign seed' do
      put api_v1_foreign_seed_path(foreign_seed), params: params, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(json.dig(:foreign_seed, :repatriation_info)).to be_present
    end
  end
end