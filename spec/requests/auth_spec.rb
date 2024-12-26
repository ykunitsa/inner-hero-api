require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  let!(:user) { create(:user) }

  describe 'POST /login' do
    it 'logs in the user and returns a token' do
      post '/login', params: { email: user.email, password: 'password' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['token']).to be_present
    end
  end

  describe 'POST /signup' do
    it 'signs up the user' do
      post '/signup', params: {
        user: { email: 'newuser@example.com', password: 'password', password_confirmation: 'password' }
      }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['user']['email']).to eq('newuser@example.com')
    end
  end
end
