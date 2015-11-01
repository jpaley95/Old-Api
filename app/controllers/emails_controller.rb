class EmailsController < ApplicationController
  ## GET /emails/:email
  def show
    if User.where(email: params[:email]).exists?
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :not_found
    end
  end
end
