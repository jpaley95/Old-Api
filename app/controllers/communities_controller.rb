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
    @community = Community.new(strong_params_for :new_community)
    if @community.parent.blank? || !current_user.can_write?(@community.parent, :children)
      raise CustomException::Forbidden
    else
      @community.save!
      render json: @community, context: current_user, status: :created
    end
  end
  
  
  ## PATCH/PUT /communities/:id
  def update
    @community = Community.find params[:id]
    if !current_user.can_write?(@community, :profile)
      raise CustomException::Forbidden
    else
      @community.update!(strong_params_for :existing_community)
      render json: @community, context: current_user
    end
  end
  
  
  ## DELETE /communities/:id
  def destroy
    @community = Community.find params[:id]
    if current_user.role_in(@community) !== 'owner'
      raise CustomException::Forbidden
    else
      @community.destroy!
      render json: @community, context: current_user
    end
  end
  
  
  
  private
  
  
  
  ## Method to create a strong parameter hash for saving a community record
  def strong_params_for(situation)
    case situation
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
  
  
  ## Method to filter parameters based on permissions
  def filter_params(params)
    if @community.role_of(current_user) !== 'owner'
      params.delete(:privacy)
      params.delete(:permission)
    end
    params
  end
end