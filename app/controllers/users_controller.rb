class UsersController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user_from_token!, except: [:create]
  
  
  
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
    @user = User.new params_for(:new_user)
    #@user.save!
    render json: @user, status: 555 #:created
    #render json: JSON.pretty_generate(params_for(:new_user)), status: 555
  end
  
  
  ## PATCH/PUT /users/:id
  def update
    @user = User.find params[:id]
    if @user == current_user
      @user.update! params_for(:current_user)
    else
      @user.update! params_for(:another_user)
    end
    render json: @user, context: current_user
  end
  
  
  ## DELETE /users/:id
  def destroy
    @user = User.find params[:id]
    @user.destroy!
    render json: @user, context: current_user
  end
  
  
  
  private
    ## Method to create a strong parameter hash for saving a user record
    def params_for(situation)
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
