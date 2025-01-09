require 'rails_helper'

RSpec.describe 'Exposures API', type: :request do
  let(:user) { create(:user) }
  let(:situation) { create(:situation) }
  let(:first_exposure) { create(:exposure, situation: situation, user: user) }
  let(:second_exposure) { create(:exposure, situation: situation) }
  let(:third_exposure) { create(:exposure, situation: situation, user: user) }
  let(:exposure_id) { third_exposure.id }
  let(:headers) { auth_headers(user) }

  before do
    first_exposure
    second_exposure
    third_exposure
  end

  describe 'GET /api/exposures' do
    before { get '/api/exposures', headers: headers }

    let(:expected_response) do
      {
        data: [
          {
            id: first_exposure.id.to_s,
            type: 'exposure',
            attributes: {
              title: first_exposure.title,
              description: first_exposure.description
            }
          },
          {
            id: third_exposure.id.to_s,
            type: 'exposure',
            attributes: {
              title: third_exposure.title,
              description: third_exposure.description
            }
          }
        ]
      }.deep_stringify_keys
    end

    it 'returns all exposures' do
      expect(response_json).to eq(expected_response)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/exposures/:id' do
    before { get "/api/exposures/#{exposure_id}", headers: headers }

    context 'when the exposure exists' do
      let(:expected_response) do
        {
          data: {
            id: third_exposure.id.to_s,
            type: 'exposure',
            attributes: {
              title: third_exposure.title,
              description: third_exposure.description
            }
          }
        }.deep_stringify_keys
      end

      it 'returns the exposure' do
        expect(response_json).to eq(expected_response)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the exposure does not belong to the user' do
      let(:exposure_id) { second_exposure.id }

      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
        expect(response_json['errors']).to include("Exposure could not be found")
      end
    end
  end

  describe 'POST /api/exposures' do
    let(:attributes) do
      {
        exposure: {
          title: 'Fear of Public Speaking',
          description: 'Gradually practice speaking in public settings.',
          situation_id: situation.id
        }
      }
    end

    before { post '/api/exposures', params: attributes, headers: headers, as: :json }

    context 'when the request is valid' do
      let(:expected_response) do
        {
          data: {
            id: Exposure.last.id.to_s,
            type: 'exposure',
            attributes: {
              title: 'Fear of Public Speaking',
              description: 'Gradually practice speaking in public settings.'
            }
          }
        }.deep_stringify_keys
      end

      it 'creates an exposure' do
        expect(response_json).to eq(expected_response)
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      let(:attributes) { { exposure: { title: '' } } }

      it 'returns an error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_json['errors']).to include("Title can't be blank")
      end
    end
  end

  describe 'PUT /api/exposures/:id' do
    let(:attributes) { { exposure: { title: 'Updated Title' } } }

    before { put "/api/exposures/#{exposure_id}", params: attributes, headers: headers, as: :json }

    context 'when the exposure exists' do
      let(:expected_response) do
        {
          data: {
            id: third_exposure.id.to_s,
            type: 'exposure',
            attributes: {
              title: 'Updated Title',
              description: third_exposure.description
            }
          }
        }.deep_stringify_keys
      end

      it 'updates the exposure' do
        expect(response_json).to eq(expected_response)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the exposure does not belong to the user' do
      let(:exposure_id) { second_exposure.id }

      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /api/exposures/:id' do
    before { delete "/api/exposures/#{exposure_id}", headers: headers }

    context 'when the exposure exists' do
      it 'deletes the exposure' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the exposure does not exist' do
      let(:exposure_id) { 999 }

      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
