class PostsController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /posts
  def index
    @posts = Post.all
    render json: @posts, context: current_user
  end
  
  
  ## POST /posts
  def create
    @post = Post.new(strong_params)
    @post.user = current_user
    authorize_action!
    @post.save!
    render json: @post, context: current_user
  end
  
  
  ## GET /posts/:id
  def show
    @post = Post.find params[:id]
    authorize_action!
    render json: @post, context: current_user
  end
  
  
  ## PATCH/PUT /posts/:id
  def update
    @post = Post.find params[:id]
    authorize_action!
    @post.update!(strong_params)
    render json: @post, context: current_user
  end
  
  
  ## DELETE /posts/:id
  def destroy
    @post = Post.find params[:id]
    authorize_action!
    @post.destroy!
    render json: @post, context: current_user
  end
  
  
  
  private
  
  
  
  ## Checks that current_user can perform action_name on @post.
  ## Throws a Exceptions::Forbidden exception if the action is forbidden.
  def authorize_action!
    case action_name
    when 'create', 'update', 'destroy'
      unless current_user.can_write?(@post)
        raise Exceptions::Forbidden
      end
    when 'show'
      unless current_user.can_read?(@post)
        raise Exceptions::Forbidden
      end
    end
  end
  
  
  
  ## Creates a strong parameter hash for mass assignment
  def strong_params
    params.require(:post).permit(param_whitelist)
  end
  
  
  
  ## Prepares a whitelist to pass into the permit() method provided by Rails'
  ##   strong parameter feature
  ## Uses @post, action_name, and current_user
  def param_whitelist
    whitelist = [
      :message,
      :privacy,
      :author_id
    ]
    
    unless action_name === 'create'
      whitelist.delete(:author_id)
    end
    
    whitelist
  end
end