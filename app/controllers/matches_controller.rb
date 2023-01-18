class MatchesController < ApplicationController
  def index
    @match = Match.new
    @match_status = Match.find_by(user_id: current_user.id)
    @room = Room.where(owner_id: current_user).or(Room.where(member_id: current_user))
    @search_gamename = params[:search_gamename]
    @search_gamehard = params[:search_gamehard]
    if @search_gamename.present? or @search_gamehard.present?
      @stand_by_users = Match.where(matching_status: "stand_by").or(Match.where(game_name: @search_gamename)).or(Match.where(game_hard: @search_gamehard))
    else
      @stand_by_users = Match.where(matching_status: "stand_by")
    end
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
    @room = Room.new
    @room.owner_id = params[:user_id]
    @room.member_id = current_user.id
    @room.save

    @match = Match.new
    @match.matching_status = 2
    @match.user_id = current_user.id
    @match.room_id = @room.id
    @match.save

    @owner_match = Match.find_by(user_id: params[:user_id])
    @owner_match.matching_status = 2
    @owner_match.room_id = @room.id
    @owner_match.update(params.permit(:matching_status))

    redirect_to room_path(@room)
  end

  private

  def match_params
    params.require(:match).permit(:matching_status, :room_comment, :game_name)
  end
end
