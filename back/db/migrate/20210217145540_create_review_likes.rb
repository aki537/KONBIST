class CreateReviewLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :review_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :review_id], unique: true
    end
  end
end
