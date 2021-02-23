module Api
  module V1
    class FoodsController < ApplicationController
      def index
        @food = Food.all.includes(:like_users)
        render json: @food.as_json(include: :like_users)
        # render json: @food.as_json(only: [:id, :name,:image],include: {like_users: {only: ['id']}})
      end

      def allfood
        food = Food.all.includes(:winter_choises)
        render json: food.as_json(include: :winter_choises)
      end

      def show
        @food = Food.includes(:like_users, {reviews: [:food, :user, :review_likes]}).find(params[:id])
        render json: @food.as_json(include: [:like_users, {reviews: {include: [{user: {only: ['id', 'image', 'name']}}, {food: {only: [:name]}}, :review_likes]}}])
      end

      def create
        @food = Food.new(food_params)

        if @food.save
          render json: @food, status: :created
        else
          render json: @food.errors, status: :unprocessable_entity
        end
      end

      def update
        @food = Food.find(params[:id])
        if @food.update(food_params)
          render json: @food
        else
          render json: { status: 400 }
        end
      end

      def destroy
        food = Food.find(params[:id])
        if food.destroy
          render json: food
        else
          render json: { status: 400 }
        end
      end

      private

      def food_params
        params.permit(:name, :details, :calorie, :carbonhydrate, :protein, :lipid, :category, :maker, :image, :release, :price)
      end
    end
  end
end
