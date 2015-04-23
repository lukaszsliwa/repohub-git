class Repositories::BranchesController < Repositories::ApplicationController
  def index
    @branches = @repository.branches
  end

  def show
    @branch = @repository.find_branch params[:id]
  end
end
