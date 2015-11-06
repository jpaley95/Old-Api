class CommunityMembersController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /community-members/members
  def index
    @community_members = CommunityMember.all
    render json: @community_members, context: current_user
  end
  
  
  ## GET /community-members/:id
  def show
    @community_member = CommunityMember.find params[:id]
    render json: @community_member, context: current_user
  end
  
  
  ## PATCH/PUT /community-members/:id
  def update
    @community_member = CommunityMember.find params[:id]
    authorize_action!
    @community_member.update!(strong_params)
    render json: @community_member, context: current_user
  end
  
  
  ## DELETE /community-members/:id
  def destroy
    @community_member = CommunityMember.find params[:id]
    authorize_action!
    @community_member.destroy!
    render json: @community_member, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @community_member.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'update'
      unless current_user.can_write?(@community, :members)
        raise CustomException::Forbidden
      end
    when 'destroy'
      unless current_user === @community_member.user
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:community_member).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @community_member, action_name, and current_user
  def param_whitelist
    [:role]
  end
end