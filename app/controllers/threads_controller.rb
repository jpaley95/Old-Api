class ThreadsController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /threads
  def index
    @threads = Thread.all
    render json: @threads, context: current_user
  end
  
  
  ## POST /threads
  def create
    @thread = Thread.new(strong_params)
    @thread.user = current_user
    authorize_action!
    @thread.save!
    render json: @thread, context: current_user
  end
  
  
  ## GET /threads/:id
  def show
    @thread = Thread.find params[:id]
    authorize_action!
    render json: @thread, context: current_user
  end
  
  
  ## PATCH/PUT /threads/:id
  def update
    @thread = Thread.find params[:id]
    authorize_action!
    if params[:thread] && params[:thread][:participant_ids] && params[:thread][:participant_ids].is_a?(Array)
      participant_ids = params[:thread][:participant_ids]
      
      # Loop through removed participant ids and make sure the user is allowed
      #   to remove them
      removed_participant_ids = (@thread.participant_ids - params[:thread][:participant_ids])
      removed_participants = Handle.where(id: removed_participant_ids)
      removed_participants.each do |handle|
        if !current_user.can_write?(handle.specific, :inbox)
          participant_ids << id
        end
      end
      
      @thread.update!(participant_ids: participant_ids)
    end
    render json: @thread, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @thread.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    unless current_user.can_write?(@thread)
      raise CustomException::Forbidden
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:thread).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @thread, action_name, and current_user
  def param_whitelist
    case action_name
    when 'create'
      [:type, :author_id, :participant_ids]
    else
      [:participant_ids]
    end
  end
end