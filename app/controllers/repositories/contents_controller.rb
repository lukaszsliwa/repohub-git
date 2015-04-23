class Repositories::ContentsController < Repositories::ApplicationController
  def index
    @tree = Tree.find @repository, params[:tree_id]
    render template: 'repositories/contents/index', formats: [:json]
  end

  def show
    @tree = Tree.find @repository, params[:tree_id], params[:id]
    render template: 'repositories/contents/index', formats: [:json]
  end
end
