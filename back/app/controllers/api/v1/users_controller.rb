module Api
  module V1
    class UsersController < ApplicationController
      def index
        @user = User.all
        render json: @user, status: :ok
      end

      def show
        @user = User.includes({foodlike: :like_users}, 
                              {reviews: [:food, :user, :review_likes]},
                              {like_reviews: [:review_likes, :food, :user]},
                              {menus: [:choise_food]},
                              :followings, :followers)
                              .find(params[:id])
        render json: @user.as_json(include: [{foodlike: {include: {like_users: {only: [:id]}}}},
                                            {reviews: {include: [:review_likes, {food: {only: [:id, :name, :image]}},
                                                                                {user: {only: [:id, :name, :image]}}]}},
                                            {like_reviews: {include: [:review_likes, {food: {only: [:id, :name, :image]}},
                                                                                     {user: {only: [:id, :name, :image]}}]}},
                                            {menus: {include: [:choise_food]}},
                                            :followings, :followers])
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: user
        else
          render json: { status: 400 }
        end
      end

      private

    end
  end
end
