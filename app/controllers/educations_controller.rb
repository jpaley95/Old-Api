class EducationsController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /educations
  def index
    @educations = Education.all
    render json: @educations, context: current_user
  end
  
  
  ## GET /educations/:id
  def show
    @education = Education.find params[:id]
    render json: @education, context: current_user
  end
  
  
  ## POST /educations
  def create
    @education = Education.new(strong_params)
    @education.user = current_user
    @education.save!
    render json: @education, context: current_user, status: :created
  end
  
  
  ## PATCH/PUT /educations/:id
  def update
    @education = Education.find params[:id]
    authorize_action!
    @education.update!(strong_params)
    render json: @education, context: current_user
  end
  
  
  ## DELETE /educations/:id
  def destroy
    @education = Education.find params[:id]
    authorize_action!
    @education.destroy!
    render json: @education, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @education.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    unless @education.user === current_user
      raise CustomException::Forbidden
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:education).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @education, action_name, and current_user
  def param_whitelist
    [
      :school_name,
      :school_id,
      :degree,
      :started_at,
      :finished_at,
      majors: [],
      minors: []
    ]
  end
end