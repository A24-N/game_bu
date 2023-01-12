class MatchesController < ApplicationController
  def index
    @match = Match.new
    @match_status = Match.find_by(user_id: current_user.id)
    @user_stand_by = Match.where(matching_status: "stand_by")
    @room = Room.where(owner_id: current_user).or(Room.where(member_id: current_user))
  end

#マッチングステータスをstand_byに変更
  def create
    @match = Match.new(match_params)
    @match.user_id = current_user.id
    @match.save
    redirect_to request.referer
  end

#マッチングステータスをafkに変更
  def destroy
    match = Match.find_by(user_id: current_user.id)
    match.destroy
    redirect_to request.referer
  end

#マッチング後にルームを作成
  def matching
    @match = Match.new
    @match.matching_status = 2
    @match.user_id = current_user.id
    @match.save

    @owner_match = Match.find_by(user_id: params[:user_id])
    @owner_match.matching_status = 2
    @owner_match.update(params.permit(:matching_status))

    @room = Room.new
    @room.owner_id = params[:user_id]
    @room.member_id = current_user.id
    @room.save

    redirect_to room_path(@room)
  end

  private

  def match_params
    params.require(:match).permit(:matching_status, :room_comment, :game_name)
  end
end
