module Api
  module V1
    class FoodLikesController < ApplicationController
      before_action :set_user

      def create
        likefood = @user.like(@food)
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

      # フードをlikeしているか真偽値を返す
      def isLike
        isLike = @user.liking?(@food)
        render json: isLike
      end

      private

      def set_user
        @user = User.find(params[:user_id])
        @food = Food.find(params[:food_id])
      end
    end
  end
end
