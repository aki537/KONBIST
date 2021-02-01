class Api::V1::FoodsController < ApplicationController
  def index
    @food = Food.all
    render json: @food, status: :ok
  end

  def show
    # @food = Food.find(params[:food_id])
    # render json: @food, status: :ok
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      render json: @food, status: :created
    else
      render json: @food.errors, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private

  def food_params
    params.permit(:name, :details, :calorie, :carbonhydrate, :protein, :lipid, :category, :maker, :image)
  end
end


