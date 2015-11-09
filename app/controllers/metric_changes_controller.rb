class MetricChangesController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /metric-changes/
  def index
    @metric_changes = MetricChange.all
    render json: @metric_changes, context: current_user
  end
  
  
  ## POST /metric-changes/
  def create
    @metric_change = MetricChange.new(strong_params)
    @metric_change.user = current_user
    authorize_action!
    @metric_change.save!
    render json: @metric_change, context: current_user
  end
  
  
  ## GET /metric-changes/:id
  def show
    @metric_change = MetricChange.find params[:id]
    authorize_action!
    render json: @metric_change, context: current_user
  end
  
  
  ## PATCH/PUT /metric-changes/:id
  def update
    @metric_change = MetricChange.find params[:id]
    authorize_action!
    @metric_change.update!(strong_params)
    render json: @metric_change, context: current_user
  end
  
  
  ## DELETE /metric-changes/:id
  def destroy
    @metric_change = MetricChange.find params[:id]
    authorize_action!
    @metric_change.destroy!
    render json: @metric_change, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @metric_change.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create', 'update', 'destroy'
      unless current_user.can_write?(@metric_change.metric.kpi.team, :kpis)
        raise CustomException::Forbidden
      end
    when 'show'
      unless current_user.can_read?(@metric_change.metric.kpi.team, :kpis)
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:metric_change).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @metric_change, action_name, and current_user
  def param_whitelist
    whitelist = [
      :comment,
      :old_progress, :new_progress,
      :metric_id
    ]
    
    unless action_name === 'create'
      whitelist.delete(:metric_id)
    end
    
    whitelist
  end
end