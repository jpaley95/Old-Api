class KpisController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /kpis
  def index
    @kpis = Kpi.all
    render json: @kpis, context: current_user
  end
  
  
  ## POST /kpis
  def create
    @kpi = Kpi.new(strong_params)
    authorize_action!
    @kpi.save!
    render json: @kpi, context: current_user
  end
  
  
  ## GET /kpis/:id
  def show
    @kpi = Kpi.find params[:id]
    authorize_action!
    render json: @kpi, context: current_user
  end
  
  
  ## PATCH/PUT /kpis/:id
  def update
    @kpi = Kpi.find params[:id]
    authorize_action!
    @kpi.update!(strong_params)
    render json: @kpi, context: current_user
  end
  
  
  ## DELETE /kpis/:id
  def destroy
    @kpi = Kpi.find params[:id]
    authorize_action!
    @kpi.destroy!
    render json: @kpi, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @kpi.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create', 'update', 'destroy'
      unless current_user.can_write?(@kpi.team, :kpis)
        raise CustomException::Forbidden
      end
    when 'show'
      unless current_user.can_read?(@kpi.team, :kpis)
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:kpi).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @kpi, action_name, and current_user
  def param_whitelist
    whitelist = [
      :name,
      :details,
      :completed,
      :started_at, :finished_at,
      :team_id
    ]
    
    unless action_name === 'create'
      whitelist.delete(:team_id)
    end
    
    whitelist
  end
end