class RequestsController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /requests
  def index
    @requests = Request.all
    render json: @requests, context: current_user
  end
  
  
  ## POST /requests
  def create
    @request = Request.new(strong_params)
    @request.user = current_user
    authorize_action!
    @request.save!
    render json: @request, context: current_user
  end
  
  
  ## GET /requests/:id
  def show
    @request = Request.find params[:id]
    authorize_action!
    render json: @request, context: current_user
  end
  
  
  ## PATCH/PUT /requests/:id
  def update
    @request = Request.find params[:id]
    authorize_action!
    @request.update!(strong_params)
    render json: @request, context: current_user
  end
  
  
  ## DELETE /requests/:id
  def destroy
    @request = Request.find params[:id]
    authorize_action!
    @request.destroy!
    render json: @request, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @request.
  ## Throws a Exceptions::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create', 'update', 'destroy'
      unless current_user.can_write?(@request)
        raise Exceptions::Forbidden
      end
    when 'show'
      unless current_user.can_read?(@request)
        raise Exceptions::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:request).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @request, action_name, and current_user
  def param_whitelist
    whitelist = [
      :message,
      :privacy,
      :author_id
    ]
    
    unless action_name === 'create'
      whitelist.delete(:author_id)
    end
    
    whitelist
  end
end