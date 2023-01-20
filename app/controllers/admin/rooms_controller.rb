class Admin::RoomsController < Admin::ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @owner = @room.owner
    @member = @room.member
    @match = Match.find_by(user_id: @owner.id)
    @messages = @room.messages
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
    redirect_to admin_rooms_path
  end

end
