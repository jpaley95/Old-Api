class CommunitiesController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /communities
  def index
    @communities = Community.all
    render json: @communitys, context: current_user
  end
  
  
  ## GET /communities/:id
  def show
    @community = Community.find params[:id]
    render json: @community, context: current_user
  end
  
  
  ## POST /communities
  def create
    @community = Community.new(strong_params_for :new_community)
    if @community.parent.blank? || !@community.parent.can?(current_user, modify: :children)
      render nothing: true, status: :unprocessable_entity
    elsif @community.save
      render json: @community, context: current_user, status: :created
    else
      render json: { errors: @community.errors }, status: :unprocessable_entity
    end
  end
  
  
  ## PATCH/PUT /communities/:id
  def update
    @community = Community.find params[:id]
    if !@community.can?(current_user, modify: :profile)
      render nothing: true, status: :unprocessable_entity
    elsif @community.update(strong_params_for :existing_community)
      render json: @community, context: current_user
    else
      render json: { errors: @community.errors }, status: :unprocessable_entity
    end
  end
  
  
  ## DELETE /communities/:id
  def destroy
    @community = Community.find params[:id]
    if @community.role_of(current_user) !== 'owner'
      render nothing: true, status: :unprocessable_entity
    elsif @community.destroy
      render json: @community, context: current_user
    else
      render json: { errors: @community.errors }, status: :unprocessable_entity
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