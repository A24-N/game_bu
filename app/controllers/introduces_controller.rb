class IntroducesController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  #cancancanによる権限確認
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @introduces = Introduce.preload(:introduce_from_user).where(introduce_to_user_id: params[:user_id]).page(params[:page]).per(6)
  end

  def new
    @user = User.find(params[:user_id])
    @introduce = Introduce.new
  end

  def create
    @user = User.find(params[:user_id])
    @introduce = Introduce.new(introduce_params)
    @introduce.introduce_from_user_id = current_user.id
    @introduce.introduce_to_user_id = @user.id
    if @introduce.save
      redirect_to user_introduces_path(@user), notice: "紹介文を保存しました:)"
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:user_id])
    introduce = Introduce.find(params[:id])
    if introduce.destroy
      redirect_to user_introduces_path(user), notice: "紹介文を削除しました:)"
    else
      redirect_to request.referer, alert: "紹介文を削除できませんでした"
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @introduce = Introduce.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @introduce = Introduce.find(params[:id])
    if @introduce.update(introduce_params)
      redirect_to user_introduces_path(@user), notice: "紹介文を編集しました:)"
    else
      render :edit
    end
  end

  private

  def introduce_params
    params.require(:introduce).permit(:body)
  end

  def ensure_correct_user
    @introduce = Introduce.find(params[:id])
    unless @introduce.introduce_from_user_id == current_user.id
      redirect_to main_path, alert: "アクセス権限がありません:<"
    end
  end
end
