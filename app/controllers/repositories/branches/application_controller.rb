class Repositories::Branches::ApplicationController < Repositories::ApplicationController
  before_filter :find_branch

  def find_branch
    @branch ||= @repository.find_branch params[:branch_id]
  end
end
