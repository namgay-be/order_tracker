require 'rails_helper'

describe 'Request new password' do
  let!(:user) { create(:user, role_id: Role.first.id) }

  context 'For valid email' do
    it 'Sends password reset instructions' do
      post user_password_path, params: { user: { email: user.email } }
      expect(status).to eq(200)

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      mail = ActionMailer::Base.deliveries.first
      expect(mail.subject).to eq(I18n.t('devise.mailer.reset_password_instructions.subject'))
    end
  end

  context 'For invalid email' do
    it 'Throws error for invalid email' do
      user.update_columns(email: '')

      post user_password_path, params: { user: { email: user.email } }
      expect(status).to eq(422)
      expect(json.dig(:errors, 0)).to eq('Email can\'t be blank')
    end
  end
end
