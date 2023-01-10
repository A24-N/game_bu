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

#マッチングステータスの切り替え
  def status_change
    @user = User.find(current_user.id)
    @user.update(user_params)
#ルームの作成
    if @user.matching_status == "stand_by"
      @room = Room.new
      @match = Match.new
      @room.owner_id = current_user.id
      @room.save
      @match.room_id = @room.id
      @match.user_id = current_user.id
      @match.save
#ルームの削除
    elsif @user.matching_status == "afk"
      @room = Room.find_by(owner_id: current_user.id)
      @match = Match.find_by(user_id: current_user.id)
      @room.destroy
      @match.destroy
    end
    redirect_to request.referer
  end

  def matching
  end

  private
  def user_params
    params.require(:user).permit(:introduction, :image, :playstyle, :activetime, :matching_status, :room_comment )
  end
end
