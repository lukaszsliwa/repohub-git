class Repositories::BranchesController < Repositories::ApplicationController
  def index
    @branches = @repository.branches
  end
end
