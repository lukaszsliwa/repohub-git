class Repositories::Tags::ApplicationController < Repositories::ApplicationController
  before_filter :find_tag

  def find_tag
    @tag ||= @repository.find_tag params[:tag_id]
  end
end
