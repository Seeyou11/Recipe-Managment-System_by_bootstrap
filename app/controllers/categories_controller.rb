class CategoriesController < ApplicationController
    before_action :set_category, only: %i[ show edit update destroy ]
    before_action :require_admin, except: %i[ show index ]

    def new
        @category = Category.new
    end

    def index
        @categories = Category.paginate(page: params[:page], per_page: 6)
    end

    def show
        @recipes = @category.recipes.paginate(page: params[:page], per_page: 6)
    end

    def edit
    end

    def create
        @category = Category.new(category_params)
        respond_to do |format|
            if @category.save
                format.html { redirect_to categories_url, notice: "Category was successfully created." }
                # format.json { render :show, status: :created, location: @category }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @category.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
        if @category.update(category_params)
            format.html { redirect_to category_url(@category), notice: "category name was successfully updated." }
            format.json { render :index, status: :ok, location: @category }
        else
            format.html { render :edit, status: :unprocessable_entity } 
            # ===========the status to :unprocessable_entity (HTTP 422), indicating a validation or processing error.
            format.json { render json: @category.errors, status: :unprocessable_entity }
        end
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin
       if !(logged_in? && current_user.admin?)
        flash[:notice] = "Only admins can perform that action."
        redirect_to categories_path
       end
    end
end