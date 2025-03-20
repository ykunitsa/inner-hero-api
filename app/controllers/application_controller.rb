class ApplicationController < ActionController::API
  include RequestErrorable

  respond_to :json

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :respond_with_record_not_found
  rescue_from ActionController::ParameterMissing, with: :respond_with_params_missing
end
