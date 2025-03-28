# frozen_string_literal: true

module Api
  module Users
    class SessionsController < Devise::SessionsController
      include RackSessionsFix

      respond_to :json

      def refresh_token
        refresh_token = request.cookies["refresh_token"]

        head :unauthorized and return if refresh_token.nil?

        current_user = find_user_by_refresh_token(refresh_token)

        head :unauthorized and return if current_user.nil?

        update_auth_tokens(current_user)

        head :ok
      rescue JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end

      private

      def find_user_by_refresh_token(token)
        payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key, true)[0]
        User.find_by(id: payload["sub"], jti: payload["jti"])
      rescue JWT::ExpiredSignature
        nil
      end

      def update_auth_tokens(user)
        user.update!(jti: SecureRandom.uuid)
        new_token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first

        response.set_cookie("refresh_token", RefreshTokenGenerator.new(user).cookie)
        response.set_header("Authorization", "Bearer #{new_token}")
      end

      def respond_with(current_user, _opts = {})
        response.set_cookie("refresh_token", RefreshTokenGenerator.new(current_user).cookie)
        render json: current_user
      end

      def respond_to_on_destroy
        response.delete_cookie("refresh_token")
        head :no_content
      end
    end
  end
end
