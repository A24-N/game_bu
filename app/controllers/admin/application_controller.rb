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
  
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: '画面を閲覧する権限がありません。'
  end
end
