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
  has_many :like_users, through: :food_likes, source: :user
  has_many :reviews, dependent: :destroy
  has_many :choise_foods, dependent: :destroy
  has_many :winter_choises, dependent: :destroy

  def avg_rate
    unless self.reviews.empty?
      # self.reviews.average(:rate).round(1)
      total_point = self.reviews.inject(0){|sum, add| sum + add.rate}
      number_of_people = self.reviews.inject(0){|sum| sum + 1}.to_f
      average = total_point / number_of_people
    else
      0.0
    end
  end

end
