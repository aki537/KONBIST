class Food < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :calorie, presence: true
  validates :carbonhydrate, presence: true
  validates :protein, presence: true
  validates :lipid, presence: true
  validates :details, presence: true
  validates :maker, presence: true
  validates :category, presence: true
  validates :price, presence: true
  validates :release, presence: true

  mount_uploader :image, ImageUploader

  has_many :food_likes, dependent: :destroy
  has_many :likeUsers, through: :food_likes, source: :user
end
