module Api
  module Exposures
    class ExposureStepsController < BaseController
      before_action :fetch_exposure_step, only: %i[show update destroy]

      def index
        exposure_steps = @exposure.exposure_steps
        render json: exposure_steps, include: []
      end

      def show
        render json: @exposure_step, include: []
      end

      def create
        exposure_step = @exposure.exposure_steps.new(exposure_step_params)

        if exposure_step.save
          render json: exposure_step, include: [], status: :created
        else
          render json: { errors: exposure_step.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @exposure_step.update(exposure_step_params)
          render json: @exposure_step, include: []
        else
          render json: { errors: @exposure_step.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @exposure_step.destroy
        head :no_content
      end

      private

      def fetch_exposure_step
        @exposure_step = @exposure.exposure_steps.find(params[:id])
      end

      def exposure_step_params
        params.require(:exposure_step).permit(:title, :description, :duration)
      end
    end
  end
end
