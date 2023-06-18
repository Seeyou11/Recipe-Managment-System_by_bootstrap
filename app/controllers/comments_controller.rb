class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
      @recipe = Recipe.find_by(id: params[:recipe_id])
      if @recipe.nil?
        redirect_to recipes_path, notice: "Recipe not found"
      else
        @comments = @recipe.comments
        render :index
      end
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    #  debugger
    # respond_to do |format|
       @comment.save
       redirect_to recipes_url
        # format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
        # format.json { render :show, status: :created, location: @comment }
      # else
      #   format.html { render :new, status: :unprocessable_entity }
      #   format.json { render json: @comment.errors, status: :unprocessable_entity }
      # end
    
  end

  

  def user_comments
    if params[:user_id]
      @user = User.find_by_id(params[:user_id])

      @comments = @user.comments.all
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :recipe_id)
    end

    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end
end
