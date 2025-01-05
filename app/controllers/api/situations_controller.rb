module Api
  class SituationsController < ApplicationController
    before_action :fetch_situation, only: %i[show update destroy]

    def index
      situations = Situation.all
      render json: situations, status: :ok
    end

    def show
      render json: @situation, status: :ok
    end

    def create
      situation = Situation.new(situation_params)
      if situation.save
        render json: situation, status: :created
      else
        render json: { errors: situation.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @situation.update(situation_params)
        render json: @situation, status: :ok
      else
        render json: { errors: @situation.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @situation.destroy
      head :no_content
    end

    private

    def fetch_situation
      @situation = Situation.find(params[:id])
    end

    def situation_params
      params.require(:situation).permit(:name, :description)
    end
  end
end
