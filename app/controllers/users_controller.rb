class UsersController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!, except: [:create]
  
  
  
  ## GET /users
  def index
    @users = User.all
    render json: @users, context: current_user
  end
  
  
  ## GET /users/:id
  def show
    @user = User.find params[:id]
    render json: @user, context: current_user
  end
  
  
  ## POST /users
  def create
    @user = User.new(strong_params_for :new_user)
    if @user.save
      render json: @user, context: current_user, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end
  
  
  ## PATCH/PUT /users/:id
  def update
    @user = User.find params[:id]
    user_type = (@user == current_user) ? :current_user : :another_user
    if @user.update(strong_params_for user_type)
      render json: @user, context: current_user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end
  
  
  ## DELETE /users/:id
  def destroy
    @user = User.find params[:id]
    if @user.destroy
      render json: @user, context: current_user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end
  
  
  
  private
    ## Method to create a strong parameter hash for saving a user record
    def strong_params_for(situation)
      case situation
        when :new_user
          params.require(:user).permit(
            :username, :email, :password,
            :first_name, :last_name,
            :overview, :biography, :headline, :ask_about,
            :website, :facebook, :twitter, :linkedin, :github,
            :birthday, :gender, :looking_for,
            roles: [],
            skills: [],
            interests: [],
            privacy: { contact: [] },
            location: [
              :description,
              :street,
              :city,
              :state,
              :zip,
              :country,
              :latitude,
              :longitude
          ])
        when :current_user
          params.require(:user).permit(
            :username,
            :first_name, :last_name,
            :overview, :biography, :headline, :ask_about,
            :website, :facebook, :twitter, :linkedin, :github,
            :birthday, :gender, :looking_for,
            roles: [],
            skills: [],
            interests: [],
            privacy: { contact: [] },
            location: [
              :description,
              :street,
              :city,
              :state,
              :zip,
              :country,
              :latitude,
              :longitude
          ])
        when :another_user
          params.require(:user).permit([:followed])
      end
    end
end
