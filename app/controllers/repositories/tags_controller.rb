class Repositories::TagsController < Repositories::ApplicationController
  def index
    @tags = @repository.tags
  end

  def show
    @tag = @repository.find_tag params[:id]
  end
end
