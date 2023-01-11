class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    @owner = @room.owner
    @member = @room.member
    @match = Match.find_by(user_id: @owner.id)
  end

  def destroy
    @room = Room.find(params[:id])
    @owner = @room.owner
    @member = @room.member
    @owner_match = Match.find_by(user_id: @owner.id)
    @member_match = Match.find_by(user_id: @member.id)
    @room.destroy
    @owner_match.destroy
    @member_match.destroy
    redirect_to matches_path
  end

  private


end
