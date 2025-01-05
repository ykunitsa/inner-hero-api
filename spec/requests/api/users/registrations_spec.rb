require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST /api/users/signup' do
    context 'when user is new' do
      it 'signs up the user' do
        post '/api/users/signup', params: {
          user: { email: 'newuser@example.com', password: 'password', password_confirmation: 'password' }
        }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(
          'data' => {
            'id' => User.last.id,
            'email' => 'newuser@example.com'
          }
        )
      end
    end

    context 'when the user is already registered' do
      before { create(:user, email: 'newuser@example.com') }

      it 'returns an error' do
        post '/api/users/signup', params: {
          user: { email: 'newuser@example.com', password: 'password', password_confirmation: 'password' }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq(
          'errors' => {
            'email' => [ 'has already been taken' ]
          }
        )
      end
    end
  end
end
