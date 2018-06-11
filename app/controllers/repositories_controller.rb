class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def create
    @repository = Repository.create params.slice(:name)
  end

  def show
    @repository = Repository.find params[:id]
  end
end
