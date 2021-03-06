class SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  # sign in
  def create
    if @usuario.valid_password?(sign_in_params[:password])
      sign_in "usuario", @usuario
      render json: {
        messages: "Signed In Successfully",
        is_success: true,
        data: {usuario: @usuario}
      }, status: :ok
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

  private
  def sign_in_params
    params.require(:usuario).permit :email, :password
  end

  def load_user
    @usuario = Usuario.find_for_database_authentication(email: sign_in_params[:email])
    if @usuario
      return @usuario
    else
      render json: {
        messages: "Cannot get User",
        is_success: false,
        data: {}
      }, status: :failure
    end
  end
end