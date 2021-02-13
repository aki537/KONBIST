module Api
  module V1
    class FoodsController < ApplicationController
      def index
        @food = Food.all.includes(:like_users)
        render json: @food.as_json(include: :like_users)
        # render json: @food.as_json(only: [:id, :name,:image],include: {like_users: {only: ['id']}})
      end

      def show
        @food = Food.find(params[:id])
        render json: @food.as_json(include: :like_users)
      end

      def create
        @food = Food.new(food_params)

        if @food.save
          render json: @food, status: :created
        else
          render json: @food.errors, status: :unprocessable_entity
        end
      end

      def destroy; end

      private

      def food_params
        params.permit(:name, :details, :calorie, :carbonhydrate, :protein, :lipid, :category, :maker, :image, :release, :price)
      end
    end
  end
end
