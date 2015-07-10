class ConfirmationsController < Devise::ConfirmationsController
  ## Setup application responding
  respond_to :html, only: []
  respond_to :xml,  only: []
  respond_to :json
  
  
  
  
  ## POST /confirmations
  def create
    super do |user|
      respond_with user, status: :created and return
    end
  end
  
  
  ## GET /confirmations?confirmation_token=abcdef
  def show
    super do |user|
      respond_with user and return
    end
  end
end