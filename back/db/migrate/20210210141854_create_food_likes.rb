class CreateFoodLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :food_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :food_id], unique: true
    end
  end
end
