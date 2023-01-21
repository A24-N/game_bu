class MessagesController < ApplicationController
  def create
    @room = Room.find_by(owner_id: current_user)
    if @room == nil
      @room = Room.find_by(member_id: current_user)
    end
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.room_id = @room.id
    @message.save
    redirect_to request.referer
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.user_id == current_user.id
      Message.find(params[:id]).destroy
    end
    redirect_to request.referer
  end

  private

  def message_params
    params.require(:message).permit(:chat)
  end
end
