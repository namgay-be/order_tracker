require 'rails_helper'

describe 'User login' do
  let!(:user_1) { create(:user, role: Role.first) }

  context 'With valid email to log in' do
    it 'Renders valid user token and updates status to active if status is inactive' do
      post user_session_path, params: { user: { email: user_1.email, password: user_1.password } }
      expect(status).to eq(200)
      expect(response.headers['Authorization']).not_to eq(nil)
    end
  end

  context 'With invalid email to log in' do
    it 'Throws invalid login error' do
      post user_session_path, params: { user: { email: 'test@mail.com', password: 'password' } }
      expect(status).to eq(401)
      expect(json.dig(:error)).to eq('Invalid Email or password.')
    end
  end
end
