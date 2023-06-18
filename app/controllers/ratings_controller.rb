class RatingsController < ApplicationController
  before_action :set_rating, only: %i[ show edit update destroy ]

  # POST /ratings or /ratings.json
  def create
    @recipe = Recipe.find(params[:rating][:recipe_id])
    @rating = @recipe.ratings.build(rating_params_for_recipe)
    @rating = Rating.new(rating_params)
    @rating.user = current_user

    respond_to do |format|
      if @rating.save
        # format.html { redirect_to recipes_url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /ratings/1 or /ratings/1.json
  def destroy
    @rating = Rating.find(params[:id])
    @recipe = @rating.recipe
    @rating.destroy
    # debugger

    respond_to do |format|
      format.html { redirect_to ratings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:value, :recipe_id, :user_id)
    end

    def rating_params_for_recipe
    params.require(:rating).permit(:value)
    end
end
