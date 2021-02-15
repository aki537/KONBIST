# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader

  has_many :food_likes, dependent: :destroy
  has_many :foodlike, through: :food_likes, source: :food
  has_many :reviews, dependent: :destroy
  has_many :food_review, through: :reviews, source: :food

  def like(other_food)
    self.food_likes.find_or_create_by(food_id: other_food.id)
  end

  def unlike(other_food)
    like = self.food_likes.find_by(food_id: other_food.id)
    like.destroy if like
  end

  def liking?(other_food)
    self.foodlike.include?(other_food)
  end
end
