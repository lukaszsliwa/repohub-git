class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  rescue_from Repository::ResourceNotFound, with: :resource_not_found
  rescue_from Repository::ResourceInvalid, with: :resource_invalid

  before_filter { request.format = 'json' }

  def resource_not_found(exception)
    render json: {type: 'error', message: exception.message, status: 404}, status: 404
  end

  def resource_invalid(exception)
    resource = exception.resource
    render json: {errors: resource.errors.full_messages}, status: 422
  end
end
