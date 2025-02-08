# frozen_string_literal: true

module Api
  module Users
    class RegistrationsController < Devise::RegistrationsController
      include RackSessionsFix

      respond_to :json

      before_action :configure_sign_up_params, only: [ :create ]
      before_action :configure_account_update_params, only: [ :update ]

      private

      def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
      end

      def respond_with(current_user, _opts = {})
        if resource.persisted?
          render json: current_user
        else
          render json: { errors: current_user.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
