class FoodLike < ApplicationRecord
  belongs_to :user
  belongs_to :food

  validates :user_id, presence: true
  validates :food_id, presence: true
end
