class ApplicationController < ActionController::API

  acts_as_token_authentication_handler_for Usuario
  
  # before_action :require_authentication!
  
  # private
  
  # def require_authentication!
  
  #   throw(:warden, scope: :usuario) unless current_usuario.presence
  
  # end
end
