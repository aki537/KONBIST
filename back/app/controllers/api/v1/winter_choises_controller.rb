module Api
  module V1
    class WinterChoisesController < ApplicationController
      def index
        food = WinterChoise.all.includes(:food)
        render json: food.as_json(include: :food)
      end

      def create
        food = WinterChoise.new(food_params)
        render json: food, status: :created if food.save
      end

      def destroy
        food = WinterChoise.find(params[:id])
        render json: food if food.destroy
      end

      private

      def food_params
        params.permit(:food_id)
      end
    end
  end
end
