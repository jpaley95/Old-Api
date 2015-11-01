class UsernamesController < ApplicationController
  ## GET /usernames/:username
  def show
    if Handle.where(username: params[:username]).exists?
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :not_found
    end
  end
end
