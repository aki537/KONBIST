module Api
  module V1
    class WinterChoisesController < ApplicationController
      def index
        food = WinterChoise.all
        render json: food
      end

      def create
        food = WinterChoise.new(food_params)
        if food.save
          render json: food, status: :created
        end
      end

      def destroy
        food = WinterChoise.find(params[:id])
        if food.destroy
          render json: food
        end
      end

      private
      
      def food_params
        params.permit(:food_id)
      end
    end
  end
end