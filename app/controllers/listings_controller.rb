class ListingsController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /listings
  def index
    @listings = Listing.all
    render json: @listings, context: current_user
  end
  
  
  ## POST /listings
  def create
    @listing = Listing.new(strong_params)
    @listing.user = current_user
    authorize_action!
    @listing.save!
    render json: @listing, context: current_user
  end
  
  
  ## GET /listings/:id
  def show
    @listing = Listing.find params[:id]
    authorize_action!
    render json: @listing, context: current_user
  end
  
  
  ## PATCH/PUT /listings/:id
  def update
    @listing = Listing.find params[:id]
    authorize_action!
    @listing.update!(strong_params)
    render json: @listing, context: current_user
  end
  
  
  ## DELETE /listings/:id
  def destroy
    @listing = Listing.find params[:id]
    authorize_action!
    @listing.destroy!
    render json: @listing, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @listing.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create', 'update', 'destroy'
      unless current_user.can_write?(@listing.handle, :listings)
        raise CustomException::Forbidden
      end
    when 'show'
      unless current_user.can_read?(@listing)
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:listing).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @listing, action_name, and current_user
  def param_whitelist
    whitelist = [
      :title, :description, :skills,
      :positions, :category, :salary_period,
      :started_at, :finished_at,
      :deadline,
      :salary_min, :salary_max, :hours,
      :equity_min, :equity_max,
      :privacy,
      :owner_id, :owner_type,
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
      whitelist.delete(:owner_id)
      whitelist.delete(:owner_type)
    end
    
    whitelist
  end
end