module Api
  module V1
    class ReviewLikesController < ApplicationController
      before_action :set_review, only: [:destroy]

      def create
        like_review = ReviewLike.new(review_params)
        if like_review.save
          render json: like_review
        else
          render json: { status: 400 }
        end
      end

      def destroy
        likereview = @user.un_like_review(@review)
        if likereview.destroy
          render json: likereview
        else
          render json: { status: 400 }
        end
      end

      private

      def set_review
        @user = User.find(params[:user_id])
        @review = Review.find(params[:review_id])
      end

      def review_params
        params.permit(:user_id, :review_id)
      end
    end
  end
end
