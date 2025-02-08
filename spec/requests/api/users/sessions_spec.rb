require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create(:user) }

  describe 'POST /api/users/login' do
    it 'logs in the user and returns user data' do
      post '/api/users/login', params: { user: { email: user.email, password: 'password' } }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(
        'user' => {
          'id' => user.id,
          'email' => user.email
        }
      )
    end
  end

  describe 'POST /api/users/logout' do
    it 'logs out the user' do
      delete '/api/users/logout', headers: auth_headers(user)

      expect(response).to have_http_status(:ok)
    end
  end
end
