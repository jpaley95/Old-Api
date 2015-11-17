class CategoriesController < ApplicationController
  ## Filters and actions
  before_action :authenticate_user!
  
  
  
  ## GET /categories
  def index
    @categories = Category.all
    render json: @categories, context: current_user
  end
  
  
  ## GET /categories/:id
  def show
    @category = Category.find params[:id]
    render json: @category, context: current_user
  end
end