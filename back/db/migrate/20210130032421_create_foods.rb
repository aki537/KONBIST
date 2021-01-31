class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :details
      t.float :calorie
      t.float :carbonhydrate
      t.float :protein
      t.float :lipid
      t.string :category
      t.string :maker

      t.timestamps
    end
  end
end
