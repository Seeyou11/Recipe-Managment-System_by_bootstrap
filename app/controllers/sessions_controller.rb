class SessionsController < ApplicationController

    def new
    end
  
    def create
        @user = User.find_by(email: params[:session][:email].downcase)
        respond_to do |format|
            if  @user &&  @user.authenticate(params[:session][:password])
                session[:user_id] = @user.id
                format.html { redirect_to @user, notice: "Logged in successfully" }
                format.json { render :show, status: :created, location: @users }
            else
                format.html { render :new, notice: "Invalid email or password."}
                format.json { render json: @users.errors, status: :unprocessable_entity }
            end
        end
    end     

    def destroy
          session[:user_id] = nil
          respond_to do |format|
            format.html { redirect_to root_path, notice: "You have successfully logged out." }
            format.json { head :no_content }
          end
    end
end