class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    if current_user.role == 1
      admin_root_path
    else
      main_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_path, alert: 'この操作を行う権限がありません。'
  end
end
