class Repositories::Branches::CommitsController < Repositories::Branches::ApplicationController
  def index
    @commits = @branch.commits

    render template: 'repositories/commits/index'
  end
end
