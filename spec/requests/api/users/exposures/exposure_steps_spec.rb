require 'rails_helper'

RSpec.describe 'ExposureSteps API', type: :request do
  let(:user) { create(:user) }
  let(:exposure) { create(:exposure, user: user) }
  let(:exposure_step) { create(:exposure_step, exposure: exposure) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/exposures/:exposure_id/exposure_steps' do
    let(:other_exposure_step) { create(:exposure_step, exposure: exposure) }
    let(:expected_response) do
      {
        exposure_steps: [
          {
            id: exposure_step.id,
            title: exposure_step.title,
            description: exposure_step.description,
            duration: exposure_step.duration
          },
          {
            id: other_exposure_step.id,
            title: other_exposure_step.title,
            description: other_exposure_step.description,
            duration: other_exposure_step.duration
          }
        ]
      }.deep_stringify_keys
    end

    before do
      exposure_step
      other_exposure_step
    end

    it 'returns all exposure steps' do
      get "/api/exposures/#{exposure.id}/exposure_steps", headers: headers

      expect(response_json).to eq(expected_response)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/exposures/:exposure_id/exposure_steps/:id' do
    let(:expected_response) do
      {
        exposure_step: {
          id: exposure_step.id,
          title: exposure_step.title,
          description: exposure_step.description,
          duration: exposure_step.duration
        }
      }.deep_stringify_keys
    end

    it 'returns the exposure step' do
      get "/api/exposures/#{exposure.id}/exposure_steps/#{exposure_step.id}", headers: headers

      expect(response_json).to eq(expected_response)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/exposures/:exposure_id/exposure_steps' do
    let(:params) do
      {
        exposure_step: {
          title: 'New Step',
          description: 'Step description',
          duration: 10
        }
      }
    end
    let(:expected_response) do
      {
        exposure_step: {
          id: ExposureStep.last.id,
          title: 'New Step',
          description: 'Step description',
          duration: 10
        }
      }.deep_stringify_keys
    end

    it 'creates a new exposure step' do
      post "/api/exposures/#{exposure.id}/exposure_steps", params: params, headers: headers, as: :json
      expect(response_json).to eq(expected_response)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /api/exposures/:exposure_id/exposure_steps/:id' do
    let(:params) { { exposure_step: { title: 'Updated Step' } } }
    let(:expected_response) do
      {
        exposure_step: {
          id: exposure_step.id,
          title: 'Updated Step',
          description: exposure_step.description,
          duration: exposure_step.duration
        }
      }.deep_stringify_keys
    end

    it 'updates the exposure step' do
      put "/api/exposures/#{exposure.id}/exposure_steps/#{exposure_step.id}", params: params, headers: headers, as: :json
      expect(response_json).to eq(expected_response)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /api/exposures/:exposure_id/exposure_steps/:id' do
    it 'deletes the exposure step' do
      delete "/api/exposures/#{exposure.id}/exposure_steps/#{exposure_step.id}", headers: headers

      expect(response).to have_http_status(:no_content)
    end
  end
end
