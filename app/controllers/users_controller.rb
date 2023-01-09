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

  def status_change
    current_user.status_change
    @user_stand_by =User.where(matching_status: 1)
    render template: "matches/index"
  end

  def matching
    # @user = User.find(params[:id])
    # @current_entry = Match.where(user_id: current_user.id)
    # @another_entry = Match.where(user_id: @user.id)
    # unless @user.id == current_user.id
    #   @current_entry.each do |current|
    #     @another_entry.each do |another|
    #       if current.room_id == another.room_id
    #         @isRoom = true
    #         @roomID = current.room_id
    #       end
    #     end
    #   end
    #   unless @isRoom
    #     @room = Room.new
    #     @match = Match.new
    #   end
    # end
  end

  private
  def user_params
    params.require(:user).permit(:introduction, :image, :playstyle, :activetime)
  end
end
