class Repositories::Trees::ApplicationController < Repositories::ApplicationController
  before_filter :find_tree

  def find_tree
    @tree = Tree.find @repository, params[:tree_id], params[:id]
  end
end
