class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  #cancancanによる権限確認
  load_and_authorize_resource

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to :root, notice: "退会しました"
    else
      redirect_to request.referer, alert: "ユーザーを削除できませんでした"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(current_user), notice: "ユーザー情報を更新しました:)"
    else
      redirect_to request.referer, alert: "ユーザー情報を更新できませんでした"
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: "DESC").limit(1)
    @introduce = Introduce.find_by(introduce_from_user_id: current_user, introduce_to_user_id: @user.id)
  end

  def onesignal_add
    # user_idは、params[:user_id]で取得
    # onesignal_user_idは、params[:onesignal_user_id]で取得
    @user = User.find(params[:user_id])
    @user.onesignal_user_id = params[:onesignal_user_id]
    @user.update(user_params_jquery)

    render status: 200, json: { status: 200, message: "Success" }
  end

  def onesignal_remove
    # user_idは、params[:user_id]で取得
    # onesignal_user_idは、params[:onesignal_user_id]で取得
    @user = User.find(params[:user_id])
    @user.onesignal_user_id = nil
    @user.update(user_params_jquery)
    render status: 200, json: { status: 200, message: "Success" }
  end

  private

  def user_params()
    params.require(:user).permit(:introduction, :image, :playstyle, :activetime, :nickname, :email, :onesignal_user_id )
  end

  def user_params_jquery
    params.permit(:introduction, :image, :playstyle, :activetime, :nickname, :email, :onesignal_user_id )
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to main_path, alert: "アクセス権限がありません:<"
    end
  end

end
