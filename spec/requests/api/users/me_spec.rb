require 'rails_helper'

RSpec.describe 'Me API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/users/me' do
    before { get '/api/users/me', headers: headers }

    let(:expected_response) do
      {
        user: {
          id: user.id,
          email: user.email
        }
      }.deep_stringify_keys
    end

    it 'returns current user' do
      expect(response_json).to eq(expected_response)
      expect(response).to have_http_status(:ok)
    end
  end
end
