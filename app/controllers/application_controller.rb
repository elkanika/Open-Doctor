# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SetCurrentStudio
  include Pagy::Backend
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Only allow modern browsers
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Requiere autenticación en toda la app
  before_action :authenticate_user!

  # Devise: permitir campos extra en sign_up y account_update
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Contador de plazos urgentes para el sidebar
  before_action :set_urgent_deadlines_count

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :studio_id, :role, :phone, :matricula])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :matricula])
  end

  def set_urgent_deadlines_count
    return unless current_user

    @urgent_deadlines_count = Deadline.pendientes.where(due_on: ..3.days.from_now.to_date).count
  end

  def user_not_authorized
    flash[:alert] = "No tienes permiso para realizar esta acción."
    redirect_back(fallback_location: root_path)
  end
end
