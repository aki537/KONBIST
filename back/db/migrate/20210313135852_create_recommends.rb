class CreateRecommends < ActiveRecord::Migration[6.0]
  def change
    create_table :recommends do |t|
      t.references :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
