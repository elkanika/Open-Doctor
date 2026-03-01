# frozen_string_literal: true

# acts_as_tenant configuration
# El tenant es el Studio (estudio jurídico)
ActsAsTenant.configure do |config|
  # No requerir tenant globalmente — lo controlamos manualmente en los controllers.
  # Devise necesita acceso a User sin tenant antes del login.
  config.require_tenant = false
end
