class CreateChoiseFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :choise_foods do |t|
      t.references :food, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps

      t.index %i[food_id menu_id], unique: true
    end
  end
end
