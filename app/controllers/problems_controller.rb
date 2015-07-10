class ProblemsController < ApplicationController
  # Filters
  before_action :authenticate_user_from_token!
  
  
  
  
  # GET /problems
  def index
    @problems = Problem.order(created_at: :desc)
    respond_with @problems
  end
  
  
  # GET /problems/:id
  def show
    @problem = Problem.find params[:id]
    respond_with @problem
  end
  
  
  # POST /problems
  def create
    @problem = Problem.new problem_params
    @problem.user = current_user
    @problem.save!
    respond_with @problem
  end
  
  
  # PATCH/PUT /problems/:id
  def update
    @problem = Problem.find params[:id]
    @problem.update! problem_params
    respond_with @problem
  end
  
  
  # DELETE /problems/:id
  def destroy
    @problem = Problem.find params[:id]
    @problem.destroy!
    respond_with @problem
  end
  
  
  
  
  private
    # Parameter whitelists
    def problem_params
      params.require(:problem).permit([
        :name,
        :text,
        :photo
      ])
    end
end
