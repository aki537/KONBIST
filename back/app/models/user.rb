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

  has_many :review_likes, dependent: :destroy
  has_many :like_reviews, through: :review_likes, source: :review

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  # def like(other_food)
  #   self.food_likes.find_or_create_by(food_id: other_food.id)
  # end

  def unlike(other_food)
    like = self.food_likes.find_by(food_id: other_food.id)
    like.destroy if like
  end

  def unLikeReview(other_review)
    like = self.review_likes.find_by(review_id: other_review.id)
    like.destroy if like
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end
