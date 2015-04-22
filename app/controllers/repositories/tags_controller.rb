class Repositories::TagsController < Repositories::ApplicationController
  def index
    @tags = @repository.tags
  end
end
