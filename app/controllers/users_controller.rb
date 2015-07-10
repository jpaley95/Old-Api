class UsersController < ApplicationController
  # Filters
  before_action :authenticate_user_from_token!, except: [:create]
  
  
  
  
  # GET /users
  def index
    @users = User.all
    respond_with @users
  end
  
  
  # GET /users/:id
  def show
    @user = User.find params[:id]
    respond_with @user
  end
  
  
  # POST /users
  def create
    @user = User.new user_params
    @user.save!
    respond_with @user
  end
  
  
  # PATCH/PUT /users/:id
  def update
    @user = User.find params[:id]
    @user.update! user_params
    respond_with @user
  end
  
  
  # DELETE /users/:id
  def destroy
    @user = User.find params[:id]
    @user.destroy!
    respond_with @user
  end
  
  
  
  
  private
    # Parameter whitelists
    def user_params
      params.require(:user).permit([
        :first_name, :last_name,
        :birthday, :gender,
        :overview, :headline, :ask_about, :looking_for,
        :website, :facebook, :twitter, :linkedin,
        :privacy,
        :email, :password, :username
      ])
    end
end
