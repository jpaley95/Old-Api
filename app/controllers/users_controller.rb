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
    @user = User.new(strong_params)
    @user.save!
    render json: @user, context: current_user, status: :created
  end
  
  
  ## PATCH/PUT /users/:id
  def update
    @user = User.find params[:id]
    @user.update!(strong_params)
    render json: @user, context: current_user
  end
  
  
  ## DELETE /users/:id
  def destroy
    @user = User.find params[:id]
    authorize_action!
    @user.destroy!
    render json: @user, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @community.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'destroy'
      unless current_user === @user
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:user).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @user, action_name, and current_user
  def param_whitelist
    if @user.present? && current_user !== @user
      return [:followed]
    end
    
    whitelist = [
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
      ]
    ]
    
    if action_name === 'update'
      whitelist.delete(:email)
      whitelist.delete(:password)
    end
    
    whitelist
  end
end
