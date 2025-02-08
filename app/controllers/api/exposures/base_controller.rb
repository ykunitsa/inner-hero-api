module Api
  module Exposures
    class BaseController < ApplicationController
      before_action :fetch_exposure

      private

      def fetch_exposure
        @exposure = Exposure.for_user(current_user).find(params[:exposure_id])
      end
    end
  end
end
