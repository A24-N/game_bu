class MatchesController < ApplicationController
  #cancancanによる権限確認
  load_and_authorize_resource

  def index
    @match = Match.new
    @match_status = Match.find_by(user_id: current_user.id)
    @room = Room.where(owner_id: current_user).or(Room.where(member_id: current_user))
    @search_gamename = params[:search_gamename]
    @search_gamehard = params[:search_gamehard]
    if @search_gamename.present? or @search_gamehard.present?
      @stand_by_users = Match.where(matching_status: "stand_by").and(Match.where(game_name: @search_gamename)).or(Match.where(game_hard: @search_gamehard))
    else
      @stand_by_users = Match.preload(:user).where(matching_status: "stand_by")
    end
  end

#マッチング待機状態へ
  def create
    @match = Match.new(match_params)
    @match.user_id = current_user.id
    if @match.save
      redirect_to request.referer, notice: "マッチング待機中です:)"
    else
      @room = Room.where(owner_id: current_user).or(Room.where(member_id: current_user))
      @stand_by_users = Match.preload(:user).where(matching_status: "stand_by")
      render :index
    end
  end

#マッチグ待機状態を解除
  def destroy
    match = Match.find_by(user_id: current_user.id)
    match.destroy
    redirect_to request.referer
  end

  def matching
    @match = Match.find_by(user_id: current_user.id)
    room_check = Room.where(owner_id: params[:user_id]).or(Room.where(member_id: params[:user_id]))
    room_check2 = Room.where(owner_id: current_user.id).or(Room.where(member_id: current_user.id))
# ユーザーがマッチング済みかの判定
# マッチングしていなければマッチング後にルームを作成
    if room_check.blank? and room_check2.blank?
      @room = Room.new
      @room.owner_id = params[:user_id]
      @room.member_id = current_user.id
      @room.save
# オーナー側マッチングステータスの更新
      @owner_match = Match.find_by(user_id: params[:user_id])
      @owner_match.matching_status = 2
      @owner_match.room_id = @room.id
      @owner_match.update(params.permit(:matching_status))
# マッチが作成されていない場合はマッチを新規作成
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
      @match.push(@owner_match)
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
