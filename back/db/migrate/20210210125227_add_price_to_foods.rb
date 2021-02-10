class AddPriceToFoods < ActiveRecord::Migration[6.0]
  def change
    add_column :foods, :price, :integer
    add_column :foods, :release, :date
  end
end
