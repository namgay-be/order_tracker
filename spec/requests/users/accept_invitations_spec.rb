require 'rails_helper'

describe 'User invitation accept', type: :request do
  let!(:user) { User.invite!(email: 'namgay@dcpl.bt', role_id: 1) }
  let!(:token) { user_token(user) }

  let!(:params) {
    {
      user: {
        password: 'password',
        password_confirmation: 'password',
        invitation_token: user.raw_invitation_token,
        name: 'john',
        phone: ' 17290332 ',
        username: 'johncena',
        designation: 'mr',
        image: image_upload
      }
    }
  }

  it 'Accepts the user invitation' do
    put user_invitation_path, params: params
    expect(status).to eq(200)
    expect(user.reload.invitation_accepted_at).to be_present
  end
end
