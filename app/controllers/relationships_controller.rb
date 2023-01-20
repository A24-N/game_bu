class RelationshipsController < ApplicationController
  #cancancanによる権限確認(followings/followersは除外)
  load_and_authorize_resource only: [:create, :destroy]

#フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
#フォローを外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
#フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(11)
  end
#フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(11)
  end
end
