class Repositories::Trees::BlobsController < Repositories::Trees::ApplicationController
  def show
    @blob = @repository.find_blob @tree.sha, params[:id]
  end
end
