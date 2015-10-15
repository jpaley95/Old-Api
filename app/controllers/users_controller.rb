class UsersController < ApplicationController
  ## Filters
  before_action :authenticate_user_from_token!, except: [:create]
  
  
  
  ## Responding
  respond_to :html, :json
  
  
  
  ## GET /users
  def index
    @users = User.all
    render json: @users
  end
  
  
  ## GET /users/:id
  def show
    @user = User.find params[:id]
    render json: @user
  end
  
  
  ## POST /users
  def create
    @user = User.new user_params
    @user.save!
    render json: @user, status: :created
  end
  
  
  ## PATCH/PUT /users/:id
  def update
    @user = User.find params[:id]
    @user.update! user_params
    render json: @user
  end
  
  
  ## DELETE /users/:id
  def destroy
    @user = User.find params[:id]
    @user.destroy!
    render json: @user
  end
  
  
  
  private
    ## Parameter whitelists
    def user_params
      if current_user.present? && user.present? && current_user != user
        other_user_params
      else
        current_user_params
      end
    end
    
    def current_user_params
      params.require(:user).permit([
        :username, :email, :password,
        :first_name, :last_name,
        :overview, :biography, :headline, :ask_about,
        :website, :facebook, :twitter, :linkedin, :github,
        :birthday,
        :avatar, :location,
        :skills, :interests, :roles,
        :gender, :looking_for
      ])
    end
    
    def other_user_params
      params.require(:user).permit([:followed])
    end
end
