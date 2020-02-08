require 'rails_helper'

module PasswordHelper
  # Somehow for the spec, the reset password token gets extra unnecessary characters
  # like \n, =, 3D. Once these characters are removed, the token is valid
  def reset_password_token # rubocop:disable Metrics/AbcSize Performance/FixedSize
    message = ActionMailer::Base.deliveries.first.to_s
    ActionMailer::Base.deliveries.clear
    rpt_index = message.index('reset_password_token=') + 'reset-password?token='.length
    replacements = [['3D', ''], ['=', '']]
    token = message[rpt_index...message.index('"', rpt_index)].gsub(/\s+/, '')
    replacements.each { |replacement| token.gsub!(replacement[0], replacement[1]) }
    token
  end
end

describe 'Update password' do
  include PasswordHelper

  let!(:user) { create(:user, role_id: Role.first.id) }

  before do
    post user_password_path, params: { user: { email: user.email } }
  end

  context 'With proper fields' do
    it 'Updates password' do
      params = {
        user: {
          reset_password_token: reset_password_token,
          password: 'MyNewAwesomePASS11',
          password_confirmation: 'MyNewAwesomePASS11'
        }
      }
      put user_password_path, params: params
      expect(status).to eq(200)
      expect(json.dig(:message)).to eq([t('devise.passwords.updated_not_active')])
    end
  end

  context 'With invalid fields' do
    let!(:params) {
      {
        user: {
          reset_password_token: reset_password_token,
          password: 'MyNewAwesomePASS11',
          password_confirmation: 'MyNewAwesomePASS11'
        }
      }
    }

    it 'Throws error if token is invalid' do
      params.dig(:user)[:reset_password_token] = 'invalid-token'
      put user_password_path, params: params
      expect(status).to eq(422)
      expect(json.dig(:errors)).to eq(["Reset password token #{t('errors.messages.invalid')}"])
    end

    it 'Throws error if password is blank' do
      params.dig(:user)[:password] = ''
      put user_password_path, params: params
      expect(status).to eq(422)
      expect(json.dig(:errors)).to eq(["Password #{t('errors.messages.blank')}"])
    end

    it 'Throws error if token is blank' do
      params.dig(:user)[:reset_password_token] = ''
      put user_password_path, params: params
      expect(status).to eq(422)
      expect(json.dig(:errors)).to eq(["Reset password token #{t('errors.messages.blank')}"])
    end

    it 'Throws error if password confirmation does not match password' do
      params.dig(:user).merge!(password: 'AFEd35sttt', password_confirmation: 'AFEd35stt5')
      put user_password_path, params: params
      expect(status).to eq(422)
      expect(json.dig(:errors)).to eq(["Password confirmation #{t('errors.messages.confirmation', attribute: 'Password')}"])
    end
  end
end
