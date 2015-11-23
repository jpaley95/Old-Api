class CommunitiesController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /communities
  def index
    @communities = Community.all
    render json: @communities, context: current_user
  end
  
  
  ## GET /communities/:id
  def show
    @community = Community.find params[:id]
    render json: @community, context: current_user
  end
  
  
  ## POST /communities
  def create
    @community = Community.new(strong_params)
    authorize_action!
    @community.save!
    CommunityMember.create!(
      community: @community,
      user:      current_user,
      role:      Role.find_by(name: 'owner'))
    render json: @community, context: current_user, status: :created
  end
  
  
  ## PATCH/PUT /communities/:id
  def update
    @community = Community.find params[:id]
    authorize_action!
    @community.update!(strong_params)
    render json: @community, context: current_user
  end
  
  
  ## DELETE /communities/:id
  def destroy
    @community = Community.find params[:id]
    authorize_action!
    @community.destroy!
    render json: @community, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @community.
  ## Throws a Exceptions::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create'
      unless @community.parent.present? && current_user.can_write?(@community.parent, :children)
        raise Exceptions::Forbidden
      end
    when 'update'
      unless current_user.can_write?(@community, :profile)
        raise Exceptions::Forbidden
      end
    when 'destroy'
      unless current_user.role_in(@community) === 'owner'
        raise Exceptions::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:community).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @community, action_name, and current_user
  def param_whitelist
    whitelist = [
      :username, :name,
      :parent_id,
      :headline, :description, :video,
      :policy, :signup_mode, :category,
      :website, :facebook, :twitter, :linkedin,
      :founded_at,
      privacy: [
        :events,
        :resources
      ],
      permission: [
        :profile,
        :members,
        :children,
        :statistics,
        :posts,
        :listings,
        :resources,
        :events
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
    
    if action_name === 'update'
      whitelist.delete(:parent_id)
      unless current_user.role_in(@community) === 'owner'
        whitelist.delete(:privacy)
        whitelist.delete(:permission)
      end
    end
    
    whitelist
  end
end