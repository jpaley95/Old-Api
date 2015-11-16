class ResourcesController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /resources
  def index
    @resources = Resource.all
    render json: @resources, context: current_user
  end
  
  
  ## POST /resources
  def create
    @resource = Resource.new(strong_params)
    authorize_action!
    @resource.save!
    render json: @resource, context: current_user
  end
  
  
  ## GET /resources/:id
  def show
    @resource = Resource.find params[:id]
    authorize_action!
    render json: @resource, context: current_user
  end
  
  
  ## PATCH/PUT /resources/:id
  def update
    @resource = Resource.find params[:id]
    authorize_action!
    @resource.update!(strong_params)
    render json: @resource, context: current_user
  end
  
  
  ## DELETE /resources/:id
  def destroy
    @resource = Resource.find params[:id]
    authorize_action!
    @resource.destroy!
    render json: @resource, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @resource.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create', 'update', 'destroy'
      unless current_user.can_write?(@resource.community, :resources)
        raise CustomException::Forbidden
      end
    when 'show'
      unless current_user.can_read?(@resource.community, :resources) && current_user.can_read?(@resource)
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:resource).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @resource, action_name, and current_user
  def param_whitelist
    whitelist = [
      :name,
      :overview,
      :website, :facebook, :twitter,
      :privacy,
      :avatar_id, :community_id, :category_ids,
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
    
    unless action_name === 'create'
      whitelist.delete(:community_id)
    end
    
    whitelist
  end
end