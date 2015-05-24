class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Exceptions::AccessDenied do |exception|
    render status: :forbidden, json: { errors: ['Access denied'] }
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render status: :not_found, json: { errors: ['Record not found'] }
  end

  def page_not_found
  	head 404
  end
end
