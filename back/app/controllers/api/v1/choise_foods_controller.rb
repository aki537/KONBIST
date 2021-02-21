module Api
  module V1
    class ChoiseFoodsController < ApplicationController
      before_action :choise_params

      def create
        @choise = ChoiseFood.new(choise_params)

        if @choise.save
          render json: @choise, status: :created
        else
          render json: { status: 400 }
        end
      end

      def destroy
        @choise = ChoiseFood.find(params[:id])
        if @choise.destroy
          render json: @choise
        else
          render json: { status: 400 }
        end
      end

      private
      
      def choise_params
        params.permit(:food_id, :menu_id)
      end
    end
  end
end
