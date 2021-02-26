module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_user

      def create
        user = @user.follow(@follow)
        render json: user
      end

      def destroy
        user = @user.unfollow(@follow)
        if user.destroy
          render json: user
        else
          render json: { status: 400 }
        end
      end

      private

      def set_user
        @user = User.find(params[:user_id])
        @follow = User.find(params[:follow_id])
      end
    end
  end
end
