class RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exist, only: :create
    # sign up
  def create
    usuario = Usuario.new usuario_params
    if usuario.save
      render json: {
        messages: "Sign Up Successfully",
        is_success: true,
        data: {usuario: usuario}
      }, status: :ok
    else
      render json: {
        messages: "Sign Up Failed",
        is_success: false,
        data: {}
      }, status: :unprocessable_entity
    end
  end
  
    private
  def usuario_params
    params.require(:usuario).permit(:email, :password, :password_confirmation, :nome, :endereco, :perfil_id)
  end
  
  def ensure_params_exist
    return if params[:usuario].present?
    render json: {
        messages: "Missing Params",
        is_success: false,
        data: {}
      }, status: :bad_request
  end
  end