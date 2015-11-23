class TeamsController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /teams
  def index
    @teams = Team.all
    render json: @teams, context: current_user
  end
  
  
  ## GET /teams/:id
  def show
    @team = Team.find params[:id]
    render json: @team, context: current_user
  end
  
  
  ## POST /teams
  def create
    @team = Team.new(strong_params)
    authorize_action!
    @team.save!
    TeamMember.create!(
      team: @team,
      user: current_user,
      role: Role.find_by(name: 'leader'))
    render json: @team, context: current_user, status: :created
  end
  
  
  ## PATCH/PUT /teams/:id
  def update
    @team = Team.find params[:id]
    authorize_action!
    @team.update!(strong_params)
    render json: @team, context: current_user
  end
  
  
  ## DELETE /teams/:id
  def destroy
    @team = Team.find params[:id]
    authorize_action!
    @team.destroy!
    render json: @team, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @team.
  ## Throws a Exceptions::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create'
      unless @team.parent.present? && current_user.can_write?(@team.parent, :children)
        raise Exceptions::Forbidden
      end
    when 'update'
      unless current_user.can_write?(@team, :profile)
        raise Exceptions::Forbidden
      end
    when 'destroy'
      unless current_user.role_in(@team) === 'owner'
        raise Exceptions::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:team).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @team, action_name, and current_user
  def param_whitelist
    [
      :name,
      :tagline, :contact, :summary, :stage,
      :website, :facebook, :twitter, :linkedin, :github,
      :founded_at,
      community_ids: [],
      sectors: [
        :commercial,
        :social,
        :research
      ],
      privacy: [
        contact: [],
        kpis: []
      ],
      permission: [
         listings: [],
         profile: [],
         posts: [],
         kpis: []
      ],
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
  end
end