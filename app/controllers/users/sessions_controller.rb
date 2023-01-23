# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :account_suspension, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]
  # include ActionController::Cookies

  # GET /resource/sign_in
  # def new
  #   super
  #   cookies[:user_id] = current_user.id
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  #guest機能
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to main_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def after_sign_in_path_for(_resource)
    if current_user.role == 1
      admin_root_path
    else
      main_path
    end
  end

  private

  def account_suspension
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && @user.is_user_deleted == true
        redirect_to root_path, alert: "管理者によって利用が停止されています。"
      end
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
