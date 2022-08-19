# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :user_type) }
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action'

    redirect_to projects_path
  end

  private

  def record_not_found
    flash[:alert] = 'Record does not exist'
    redirect_back(fallback_location: projects_path)
  end
end
