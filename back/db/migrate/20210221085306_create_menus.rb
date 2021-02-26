class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.string :timezone
      t.integer :timezone_number

      t.timestamps

      t.index %i[user_id date timezone], unique: true
    end
  end
end
