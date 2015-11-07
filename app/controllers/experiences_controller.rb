class ExperiencesController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /experiences
  def index
    @experiences = Experience.all
    render json: @experiences, context: current_user
  end
  
  
  ## GET /experiences/:id
  def show
    @experience = Experience.find params[:id]
    render json: @experience, context: current_user
  end
  
  
  ## POST /experiences
  def create
    @experience = Experience.new(strong_params)
    @experience.user = current_user
    @experience.save!
    render json: @experience, context: current_user, status: :created
  end
  
  
  ## PATCH/PUT /experiences/:id
  def update
    @experience = Experience.find params[:id]
    authorize_action!
    @experience.update!(strong_params)
    render json: @experience, context: current_user
  end
  
  
  ## DELETE /experiences/:id
  def destroy
    @experience = Experience.find params[:id]
    authorize_action!
    @experience.destroy!
    render json: @experience, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @experience.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    unless @experience.user === current_user
      raise CustomException::Forbidden
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:experience).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @experience, action_name, and current_user
  def param_whitelist
    [
      :title,
      :description,
      :organization,
      :team_id,
      :started_at,
      :finished_at,
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
  end
end