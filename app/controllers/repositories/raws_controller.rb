class Repositories::RawsController < Repositories::ApplicationController
  def show
    @blob = @repository.find_blob params[:tree_id], params[:id]

    send_data @blob.content, filename: @blob.name, disposition: 'inline', type: 'application/octet-stream'
  end
end
