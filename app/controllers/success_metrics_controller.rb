class SuccessMetricsController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /success-metrics/
  def index
    @success_metrics = SuccessMetric.all
    render json: @success_metrics, context: current_user
  end
  
  
  ## POST /success-metrics/
  def create
    @success_metric = SuccessMetric.new(strong_params)
    authorize_action!
    @success_metric.save!
    render json: @success_metric, context: current_user
  end
  
  
  ## GET /success-metrics/:id
  def show
    @success_metric = SuccessMetric.find params[:id]
    authorize_action!
    render json: @success_metric, context: current_user
  end
  
  
  ## PATCH/PUT /success-metrics/:id
  def update
    @success_metric = SuccessMetric.find params[:id]
    authorize_action!
    @success_metric.update!(strong_params)
    render json: @success_metric, context: current_user
  end
  
  
  ## DELETE /success-metrics/:id
  def destroy
    @success_metric = SuccessMetric.find params[:id]
    authorize_action!
    @success_metric.destroy!
    render json: @success_metric, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @success_metric.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create', 'update', 'destroy'
      unless current_user.can_write?(@success_metric.kpi.team, :kpis)
        raise CustomException::Forbidden
      end
    when 'show'
      unless current_user.can_read?(@success_metric.kpi.team, :kpis)
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:success_metric).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @success_metric, action_name, and current_user
  def param_whitelist
    whitelist = [
      :description,
      :progress,
      :kpi_id
    ]
    
    unless action_name === 'create'
      whitelist.delete(:kpi_id)
    end
    
    whitelist
  end
end