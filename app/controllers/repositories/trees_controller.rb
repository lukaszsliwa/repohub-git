class Repositories::TreesController < Repositories::ApplicationController
  def show
    @tree = Tree.find @repository, params[:id]
  end
end
