class Repositories::CommitsController < Repositories::ApplicationController
def index
    @commits = @repository.commits
end

  def show
    @commit = @repository.find_commit params[:id]
  end
end
