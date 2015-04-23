class Repositories::BlobsController < Repositories::ApplicationController
  def show
    @blob = @repository.find_blob params[:tree_id], params[:id]
  end
end
