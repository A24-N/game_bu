class Admin::UsersController < Admin::ApplicationController
  authorize_resource
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_user_path(user), notice: "情報を更新しました。"
  end

  private

  def user_params
    params.require(:user).permit(:introduction, :image, :playstyle, :activetime, :is_user_deleted)
  end

end
