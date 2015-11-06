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
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create'
      unless @community.parent.present? && current_user.can_write?(@community.parent, :children)
        raise CustomException::Forbidden
      end
    when 'update'
      unless current_user.can_write?(@community, :profile)
        raise CustomException::Forbidden
      end
    when 'destroy'
      unless current_user.role_in(@community) === 'owner'
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  
  
  
  
  
  
  
  
  
  ## Creates a strong parameter hash for 
  def strong_params
    params.require(:community).permit(param_whitelist)
  end
  
  
  def param_whitelist(action = nil)
    case action || action_name
    when 'create'
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
    when 'update'
      whitelist = param_whitelist('create')
      whitelist.delete(:parent_id)
      unless @community.role_of(current_user) === 'owner'
        whitelist.delete(:privacy)
        whitelist.delete(:permission)
      end
      whitelist
    else
      []
    end
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  ## Calls filter_params and strong_params on the parameter hash to construct a
  ##   safe, strong parameter hash ready for mass assignment
  def safe_params
    strong_params(filter_params params)
  end
  
  
  ## Filters a parameter hash for mass assignment based on:
  ##   * action_name
  ##   * current_user
  ##   * @community (if present)
  def filter_params(params)
    params = params.dup
    case action_name
    when 'update'
      if @community.present? && @community.role_of(current_user) !== 'owner'
        params.delete(:privacy)
        params.delete(:permission)
      end
    end
    params
  end
  
  
  
  ## Creates a strong parameter hash for community mass assignment based on:
  ##   * action_name
  ##   * current_user
  ##   * @community (if present)
  def strong_params(params)
    case action_name
      when :new_community
        params.require(:community).permit(
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
        ])
      when :existing_community
        p = strong_params_for(:new_community)
        p.delete(:parent_id)
        p
    end
  end
end