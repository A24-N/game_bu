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

#マッチング待機状態へ
  def create
    @match = Match.new(match_params)
    @match.user_id = current_user.id
    if @match.save
      redirect_to request.referer, notice: "マッチング待機中です:)"
    else
      redirect_to request.referer, alert: "入力情報を確認してください:<"
    end
  end

#マッチグ待機状態を解除
  def destroy
    match = Match.find_by(user_id: current_user.id)
    match.destroy
    redirect_to request.referer
  end

#マッチング後にルームを作成
  def matching
    @match = Match.find_by(user_id: current_user.id)
    room_check = Room.where(owner_id: params[:user_id]).or(Room.where(member_id: params[:user_id]))
    room_check2 = Room.where(owner_id: current_user.id).or(Room.where(member_id: current_user.id))
# ユーザーが既にマッチング済みかの判定
    if room_check.blank? and room_check2.blank?
      @room = Room.new
      @room.owner_id = params[:user_id]
      @room.member_id = current_user.id
      @room.save

      @owner_match = Match.find_by(user_id: params[:user_id])
      @owner_match.matching_status = 2
      @owner_match.room_id = @room.id
      @owner_match.update(params.permit(:matching_status))

# マッチが作成されていない場合はマッチを
      if @match.blank?
        @match = Match.new
      end
      @match.matching_status = 2
      @match.user_id = current_user.id
      @match.room_id = @room.id
      @match.room_comment = @owner_match.room_comment
      @match.game_name = @owner_match.game_name
      @match.game_hard = @owner_match.game_hard
      @match.save

      redirect_to room_path(@room)
    else
      redirect_to request.referer, alert: "既に他のユーザーとマッチ中です:<"
    end
  end

  private

  def match_params
    params.require(:match).permit(:matching_status, :room_comment, :game_name, :game_hard)
  end
end
