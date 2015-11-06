class TeamMembersController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /team-members/members
  def index
    @team_members = TeamMember.all
    render json: @team_members, context: current_user
  end
  
  
  ## GET /team-members/:id
  def show
    @team_member = TeamMember.find params[:id]
    render json: @team_member, context: current_user
  end
  
  
  ## PATCH/PUT /team-members/:id
  def update
    @team_member = TeamMember.find params[:id]
    authorize_action!
    @team_member.update!(strong_params)
    render json: @team_member, context: current_user
  end
  
  
  ## DELETE /team-members/:id
  def destroy
    @team_member = TeamMember.find params[:id]
    authorize_action!
    @team_member.destroy!
    render json: @team_member, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @team_member.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'update'
      unless current_user.can_write?(@team, :members)
        raise CustomException::Forbidden
      end
    when 'destroy'
      unless current_user.can_write?(@team, :members) || current_user === @team_member.user
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:team_member).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @team_member, action_name, and current_user
  def param_whitelist
    [:role, :title]
  end
end