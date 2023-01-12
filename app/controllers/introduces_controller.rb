class IntroducesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @introduces = Introduce.where(introduce_to_user_id: params[:user_id])
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
    redirect_to user_introduces_path
  end

  def edit
  end

  private
  def introduce_params
    params.require(:introduce).permit(:body)
  end
end
