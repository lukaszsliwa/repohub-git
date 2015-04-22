class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  rescue_from NotFoundException, with: :not_found

  def not_found(exception)
    render json: {type: 'error', message: exception.message, status: 404}, status: :not_found
  end
end
