class RoomsController < ApplicationController
  before_action :room_user_check, only: [:show, :destroy]
  #cancancanによる権限確認
  load_and_authorize_resource

  def show
    @room = Room.find(params[:id])
    @owner = @room.owner
    @member = @room.member
    @match = Match.find_by(user_id: @owner.id)
    @message = Message.new
    @messages = @room.messages
  end

  def destroy
    @room = Room.find(params[:id])
    @owner = @room.owner
    @member = @room.member
    @owner_match = Match.find_by(user_id: @owner.id)
    @member_match = Match.find_by(user_id: @member.id)
    if @room.destroy
      @owner_match.destroy
      @member_match.destroy
      redirect_to matches_path
    else
      redirect_to request.referer, alert: "ルームを削除できませんでした"
    end
  end

  private

  def room_user_check
    @room = Room.find(params[:id])
    unless @room.owner_id == current_user.id or @room.member_id == current_user.id
      redirect_to main_path, alert: "アクセス権限がありません:<"
    end
  end
end
