class ListingMembersController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /listing_members
  def index
    @listing_members = ListingMember.all
    render json: @listing_members, context: current_user
  end
  
  
  ## GET /listing_members/:id
  def show
    @listing_member = ListingMember.find params[:id]
    authorize_action!
    render json: @listing_member, context: current_user
  end
  
  
  ## PATCH/PUT /listing_members/:id
  def update
    @listing_member = ListingMember.find params[:id]
    authorize_action!
    @listing_member.update!(strong_params)
    render json: @listing_member, context: current_user
  end
  
  
  ## DELETE /listing_members/:id
  def destroy
    @listing_member = ListingMember.find params[:id]
    authorize_action!
    @listing_member.destroy!
    render json: @listing_member, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @listing_member.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'update', 'destroy'
      unless current_user.can_write?(@listing_member.listing.handle, :listings)
        raise CustomException::Forbidden
      end
    when 'show'
      unless current_user.can_read?(@listing_member.listing)
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:listing_member).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @listing_member, action_name, and current_user
  def param_whitelist
    [:rating, :review]
  end
end