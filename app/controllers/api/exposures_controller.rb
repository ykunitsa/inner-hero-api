module Api
  class ExposuresController < ApplicationController
    before_action :fetch_exposure, only: [ :show, :update, :destroy ]

    def index
      @exposures = Exposure.for_user(current_user).includes(:situation)
      render json: @exposures, include: [], status: :ok
    end

    def show
      render json: @exposure, include: [], status: :ok
    end

    def create
      @exposure = Exposure.new(create_exposure_params)

      if @exposure.save
        render json: @exposure, include: [], status: :created
      else
        render json: { errors: @exposure.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @exposure.update(update_exposure_params)
        render json: @exposure, include: [], status: :ok
      else
        render json: { errors: @exposure.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @exposure.destroy
      head :no_content
    end

    private

    def fetch_exposure
      @exposure = Exposure.for_user(current_user).find(params[:id])
    end

    def create_exposure_params
      params.require(:exposure).permit(:title, :description, :situation_id).merge(user_id: current_user.id)
    end

    def update_exposure_params
      params.require(:exposure).permit(:title, :description)
    end
  end
end
