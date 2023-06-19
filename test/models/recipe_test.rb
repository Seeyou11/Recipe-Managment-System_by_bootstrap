require "test_helper"

class RecipeTest < ActiveSupport::TestCase

  def setup 
   @recipe = Recipe.new(title: "Snack", description: "description of snack", preparation_steps: "test test test test", user_id: 1, category_id: 1)
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end
end
