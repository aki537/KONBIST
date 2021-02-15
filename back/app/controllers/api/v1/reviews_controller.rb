module Api
  module V1
    class ReviewsController < ApplicationController

      def create
        review = Review.new(review_params)
        if review.save
          render json: review
        else
          render json: { status: 400 }
        end
      end

      def destroy
        review = Review.find(params[:id])
        if review.destroy
          render json: review
        else
          render json: { status: 400 }
        end
      end

      private

      # def set_user
      #   @user = User.find(params[:user_id])
      #   @food = Food.find(params[:food_id])
      # end

      def review_params
        params.permit(:user_id, :food_id, :title, :content, :image)
      end
    end
  end
end
