class MatchesController < ApplicationController
  def index
    @user = current_user
    @user_stand_by =User.where(matching_status: 1)
  end

  def matching
    @room = Room.find_by(owner_id: params[:user_id])
    redirect_to room_path(@room)
  end
end
