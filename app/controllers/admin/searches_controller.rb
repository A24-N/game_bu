class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @posts = Post.where(user_id: params[:user_id])
    @introduces = Introduce.where(introduce_from_user_id: params[:introduce_from_user_id])
  end
end
