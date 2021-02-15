class Review < ApplicationRecord
  belongs_to :user
  belongs_to :food

  validates :user_id, presence: true
  validates :food_id, presence: true
  validates :content, presence: true

  mount_uploader :image, ImageUploader
end
