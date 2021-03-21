module Api
  module V1
    class UsersController < ApplicationController
      def index
        @user = User.all
        render json: @user, status: :ok
      end

      def show
        @user = User.includes({ foodlike: :like_users },
                              { reviews: [:food, :user, { review_likes: :user },] },
                              { like_reviews: [:food, :user, { review_likes: :user },] },
                              { menus: [:choise_food] },
                              :followings, :followers)
                    .find(params[:id])
        render json: @user.as_json(include: [{ foodlike: { include: { like_users: { only: [:id] } } } },
                                             { reviews: { include: [{ review_likes: { include: [{ user: { only: %w[id image name] }},] } }, { food: { only: %i[id name image] } },
                                                                    { user: { only: %i[id name image] } }] } },
                                             { like_reviews: { include: [{ review_likes: { include: [{ user: { only: %w[id image name] }},] } }, { food: { only: %i[id name image] } },
                                                                         { user: { only: %i[id name image] } }] } },
                                             { menus: { include: [:choise_food] } },
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

      def search
        if params[:search]
          @user = User.search(params[:search]).includes(:followings, :followers)
          render json: @user.as_json(include: %i[followings followers])
        end
      end

    end
  end
end
