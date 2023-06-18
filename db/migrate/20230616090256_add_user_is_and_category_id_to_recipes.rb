class AddUserIsAndCategoryIdToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :user_id, :int
    add_column :recipes, :category_id, :int
  end
end
