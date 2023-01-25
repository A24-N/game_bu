class Admin::ApplicationController < ApplicationController
  before_action :check_admin_authorization

  private

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def check_admin_authorization
    authorize!(:access_admin_page, :all) if request.path.start_with?('/admin')
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_path, alert: 'この操作を行う権限がありません。'
  end
end
