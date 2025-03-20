module Api
  module Users
    class MeController < ApplicationController
      def show
        render json: current_user
      end
    end
  end
end
