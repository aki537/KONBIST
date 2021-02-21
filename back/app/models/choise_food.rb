class ChoiseFood < ApplicationRecord
  belongs_to :food
  belongs_to :menu

  validates :food_id, presence: true
  validates :menu_id, presence: true
end
