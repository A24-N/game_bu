class UsersController < ApplicationController
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to :root
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(current_user)
  end

  def show
    @user = User.find(params[:id])
  end



  private
  def user_params
    params.require(:user).permit(:introduction, :image, :playstyle, :activetime )
  end
end
