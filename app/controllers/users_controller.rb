class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  #cancancanによる権限確認
  load_and_authorize_resource

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to :root, alert: "ユーザーを削除しました"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(current_user), notice: "更新しました:)"
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: "DESC").limit(1)
    @introduce = Introduce.find_by(introduce_from_user_id: current_user)
  end



  private
  def user_params
    params.require(:user).permit(:introduction, :image, :playstyle, :activetime )
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to main_path, alert: "アクセス権限がありません:<"
    end
  end

end
