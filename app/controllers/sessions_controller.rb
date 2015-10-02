class SessionsController < Devise::SessionsController
  ## Setup application responding
  respond_to :html, only: []
  respond_to :xml,  only: []
  respond_to :json
  
  
  
  
  ## POST /sessions
  def create
    super do |user|
      data = {
        token:    user.authentication_token,
        email:    user.email,
        username: user.username
      }
      render json: data, status: :created and return
    end
  end
  
  
  ## DELETE /sessions
  def destroy
    super do |user|
      render head: :no_content and return
    end
  end
  
  
  
  
  ## Stop devise from flashing errors
  def is_flashing_format?
    false
  end
end