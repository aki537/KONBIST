class Menu < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :date, presence: true
  validates :timezone, presence: true
  validates :timezone_number, presence: true
  validates :user_id,  uniqueness: { scope: [:date, :timezone]  }

  has_many :choise_foods, dependent: :destroy
  has_many :choise_food, through: :choise_foods, source: :food
end
