class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.referer, alert: 'この操作を行う権限がありません。'
  end

  def record_not_found
    redirect_to error_path
  end

end
