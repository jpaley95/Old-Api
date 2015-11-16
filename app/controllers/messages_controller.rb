class MessagesController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /messages
  def index
    @messages = Message.all
    render json: @messages, context: current_user
  end
  
  
  ## POST /messages
  def create
    @message = Message.new(strong_params)
    @message.user = current_user
    authorize_action!
    @message.save!
    render json: @message, context: current_user
  end
  
  
  ## GET /messages/:id
  def show
    @message = Message.find params[:id]
    authorize_action!
    render json: @message, context: current_user
  end
  
  
  ## PATCH/PUT /messages/:id
  def update
    @message = Message.find params[:id]
    authorize_action!
    @message.update!(strong_params)
    render json: @message, context: current_user
  end
  
  
  ## DELETE /messages/:id
  def destroy
    @message = Message.find params[:id]
    authorize_action!
    @message.destroy!
    render json: @message, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @message.
  ## Throws a CustomException::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create', 'update', 'destroy'
      unless current_user.can_write?(@message)
        raise CustomException::Forbidden
      end
    when 'show'
      unless current_user.can_read?(@message)
        raise CustomException::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:message).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @message, action_name, and current_user
  def param_whitelist
    whitelist = [
      :content,
      :author_id,
      :thread_id
    ]
    
    unless action_name === 'create'
      whitelist.delete(:author_id)
      whitelist.delete(:thread_id)
    end
    
    whitelist
  end
end