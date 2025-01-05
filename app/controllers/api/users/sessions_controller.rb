# frozen_string_literal: true

module Api
  module Users
    class SessionsController < Devise::SessionsController
      include RackSessionsFix

      respond_to :json

      private

      def respond_with(current_user, _opts = {})
        render json: { data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] } }
      end

      def respond_to_on_destroy
        if request.headers["Authorization"].present?
          jwt_payload = JWT.decode(
            request.headers["Authorization"].split(" ").last, Rails.application.credentials.devise_jwt_secret_key!
          ).first
          current_user = User.find(jwt_payload["sub"])
        end

        current_user ? head(:ok) : head(:unauthorized)
      end
    end
  end
end
