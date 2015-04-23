class Repositories::Trees::ContentsController < Repositories::Trees::ApplicationController
  def index
    @contents = @tree.contents
  end

  def show
    @contents = @tree.contents
    render template: 'repositories/trees/contents/index', formats: [:json]
  end
end
