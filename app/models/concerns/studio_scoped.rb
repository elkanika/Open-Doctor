# frozen_string_literal: true

# Concern reutilizable para aplicar multitenancy a modelos.
# Incluye acts_as_tenant y la validación de presencia de studio.
module StudioScoped
  extend ActiveSupport::Concern

  included do
    acts_as_tenant(:studio)
    belongs_to :studio
  end
end
