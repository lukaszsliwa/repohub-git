class Repositories::Tags::CommitsController < Repositories::Tags::ApplicationController
  def index
    @commits = @tag.commits

    render template: 'repositories/commits/index'
  end
end
