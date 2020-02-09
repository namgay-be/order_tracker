require 'rails_helper'

describe 'User invitation', type: :request do
  let!(:user) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(user) }

  context 'With valid params' do
    let!(:params) {
      {
        user: {
          email: 'namgay.tenzin@dcpl.bt',
          role_id: 2
        }
      }
    }

    it 'Sends the invite to the user' do
      post user_invitation_path, params: params, headers: header_params(token: token)
      expect(status).to eq(200)

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.subject).to eq(t('devise.mailer.invitation_instructions.subject'))
    end
  end
end
