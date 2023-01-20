class IntroducesController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @introduces = Introduce.where(introduce_to_user_id: params[:user_id]).page(params[:page]).per(6)
  end

  def new
    @user = User.find(params[:user_id])
    @introduce = Introduce.new
  end

  def create
    user = User.find(params[:user_id])
    introduce = Introduce.new(introduce_params)
    introduce.introduce_from_user_id = current_user.id
    introduce.introduce_to_user_id = user.id
    introduce.save
    redirect_to user_introduces_path(user)
  end

  def destroy
    user = User.find(params[:user_id])
    introduce = Introduce.find(params[:id])
    introduce.destroy
    redirect_to user_introduces_path(user)
  end

  def edit
    @user = User.find(params[:user_id])
    @introduce = Introduce.find(params[:id])
  end

  def update
    user = User.find(params[:user_id])
    introduce = Introduce.find(params[:id])
    introduce.update(introduce_params)
    redirect_to user_introduces_path(user)
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
