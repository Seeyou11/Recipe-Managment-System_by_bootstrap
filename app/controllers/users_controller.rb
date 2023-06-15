class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
    # before_action :require_user, except: %i[ show index ]
    before_action :require_same_user, only: %i[ edit update destroy ]


    def new
        @user = User.new
        @article = Article.new
    end
    
    def index
        @users =  User.paginate(page: params[:page], per_page: 5)
    end

    def edit
    end

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                session[:user_id] = @user.id
                format.html { redirect_to articles_url, notice: "Welcome #{@user.username}, you have successfully signup." }
                format.json { render :show, status: :created, location: @article }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end 

    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to users_url, notice: "Welcome #{@user.username}, you have successfully updated your account." }
                format.json { render :user, status: :created, location: @article }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @article.errors, notice: "Welcome #{@user.username}, you have successfully updated your account." }
            end
        end
    end

    def destroy
      @user.destroy
      session[:user_id] = nil if @user == current_user
      respond_to do |format|
        format.html { redirect_to articles_url, notice: "Your profile  was successfully destroyed." }
        format.json { head :no_content }
      end
  end

    private
     def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
         flash[:notice] = "You can only edit or delete your own profile."
         redirect_to @user  
      end
    end
end