# frozen_string_literal: true

# Concern para setear el tenant (Studio) actual basado en el usuario autenticado.
module SetCurrentStudio
  extend ActiveSupport::Concern

  included do
    before_action :set_current_studio
  end

  private

  def set_current_studio
    return unless current_user

    ActsAsTenant.current_tenant = current_user.studio
  end
end
