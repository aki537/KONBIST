module Api
  module V1
    class FoodLikesController < ApplicationController
      before_action :set_user, only: [:destroy]

      def create
        likefood = FoodLike.new(like_params)
        if likefood.save
          render json: @user
        else
          render json: { status: 400 }
        end
      end

      def destroy
        likefood = @user.unlike(@food)
        if likefood.destroy
          render json: @user
        else
          render json: { status: 400 }
        end
      end

      private

      def set_user
        @user = User.find(params[:user_id])
        @food = Food.find(params[:food_id])
      end

      def like_params
        params.permit(:user_id, :food_id)
      end
    end
  end
end
