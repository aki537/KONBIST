class Api::V1::auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  
  private

  # ストロングパラメーター設定
  def sign_up_params
    params.permit(:name, :email, :password, :password_confirmation, :image)
  end

  def account_update_params
    params.permit(:name, :email, :image)
  end
end