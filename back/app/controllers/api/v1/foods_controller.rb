module Api
  module V1
    class FoodsController < ApplicationController
      def index
        @food = Food.all.includes(:like_users, :reviews)
        render json: @food.as_json(include: %i[like_users reviews], methods: :avg_rate)
        # render json: @food.as_json(only: [:id, :name,:image],include: {like_users: {only: ['id']}})
      end

      def allfood
        food = Food.all.includes(:winter_choises)
        render json: food.as_json(include: :winter_choises)
      end

      def new_food
        from = Time.current.at_beginning_of_day
        to = (from - 1.month)
        @food = Food.where(release: to...from).order(release: :desc)
        render json: @food
      end

      def new_plan_food
        from = Time.current.at_beginning_of_day
        to = (from + 1.month)
        @food = Food.where(release: from...to)
        render json: @food
      end

      # def total_rank
      #   @foods = Food.find(FoodLike.group(:food_id).order('count(food_id) desc').limit(50).pluck(:food_id))
      #   render json: @foods
      # end

      def show
        @food = Food.includes(:like_users, { reviews: %i[food user review_likes] }).find(params[:id])
        render json: @food.as_json(include: [:like_users, { reviews: { include: [{ user: { only: %w[id image name] } },
                                                                                 { food: { only: [:name] } },
                                                                                 :review_likes] } }],
                                   methods: :avg_rate)
      end

      def create
        @food = Food.new(food_params)

        if @food.save
          render json: @food, status: :created
        else
          render json: { status: 400 }
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
