module Api
  module V1
    class MenusController < ApplicationController
      before_action :menu_params

      def index
        @menu = Menu.all
        render json: @menu
      end

      def create
        @menu = Menu.new(menu_params)

        if @menu.save
          render json: @menu, status: :created
        else
          render json: @menu.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @menu = Menu.find(params[:id])
        if @menu.destroy
          render json: @menu
        else
          render json: @menu.errors
        end
      end

      private

      def menu_params
        params.permit(:user_id, :date, :timezone, :timezone_number)
      end
    end
  end
end
