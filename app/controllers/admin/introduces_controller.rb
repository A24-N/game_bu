class Admin::IntroducesController < Admin::ApplicationController
  def index
    @introduces = Introduce.preload(:introduce_from_user, :introduce_to_user).all
  end

  def show
    @introduce = Introduce.find(params[:id])
  end

  def destroy
    introduce = Introduce.find(params[:id])
    if introduce.destroy
      redirect_to admin_introduces_path, notice: "紹介文を削除しました"
    else
      redirect_to request.referer, alert: "紹介文を削除できませんでした"
    end
  end
end
