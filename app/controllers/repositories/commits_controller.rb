class Repositories::CommitsController < Repositories::ApplicationController
  before_filter :find_reference

  def index
    @commits = @reference.commits params.slice(:from, :to, :sha)
  end

  def show
    @commit = @reference.find_commit params[:id]
  end

  def first
    @commit = @reference.commits(params.slice(:from, :to, :sha).merge(limit: 1)).first
  end

  private

  def find_reference
    @reference = params[:tree_id].present? ? repository.find_tree(params[:tree_id]) : @repository
  end
end
