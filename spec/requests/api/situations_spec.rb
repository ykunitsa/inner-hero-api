require 'rails_helper'

RSpec.describe 'Situations API', type: :request do
  let(:user) { create(:user) } # Assuming a factory for User exists

  let!(:situations) { create_list(:situation, 5) }
  let(:situation_id) { situations.first.id }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/situations' do
    before { get '/api/situations', headers: headers }

    it 'returns all situations' do
      expect(response_json['situations'].count).to eq(5)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/situations/:id' do
    before { get "/api/situations/#{situation_id}", headers: headers }

    it 'returns the situation' do
      expect(response_json['situation']['id']).to eq(situation_id)
      expect(response).to have_http_status(:ok)
    end

    context 'when the situation does not exist' do
      let(:situation_id) { 999 }

      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
        expect(response_json['errors']).to include("Situation could not be found")
      end
    end
  end

  describe 'POST /api/situations' do
    let(:attributes) do
      {
        situation: {
          name: 'Public Speaking',
          description: 'A public speaking situation'
        }
      }
    end


    before { post '/api/situations', params: attributes, headers: headers, as: :json }

    context 'when the request is valid' do
      it 'creates a situation' do
        expect(response_json['situation']['name']).to eq('Public Speaking')
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      let(:attributes) do
        {
          situation: {
            name: ''
          }
        }
      end

      it 'returns an error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_json["errors"]).to include("Name can't be blank")
      end
    end
  end

  describe 'PUT /api/situations/:id' do
    let(:attributes) { { situation: { name: 'Updated Name' } } }

    before { put "/api/situations/#{situation_id}", params: attributes, headers: headers, as: :json }

    context 'when the situation exists' do
      it 'updates the situation' do
        expect(response_json['situation']['name']).to eq('Updated Name')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the request is invalid' do
      let(:attributes) do
        {
          situation: {
            name: ''
          }
        }
      end

      it 'returns an error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_json["errors"]).to include("Name can't be blank")
      end
    end

    context 'when the situation does not exist' do
      let(:situation_id) { 999 }

      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /api/situations/:id' do
    before { delete "/api/situations/#{situation_id}", headers: headers }

    it 'deletes the situation' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
