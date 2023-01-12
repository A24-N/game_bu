class FavoritesController < ApplicationController
  def create
    @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
    @post_favorite.save
    redirect_to request.referer
  end

  def destroy
    @post_favorite = Favorite.find_by(user_id: current_user, post_id: params[:post_id])
    @post_favorite.destroy
    redirect_to request.referer
  end

  def favorite
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @posts = Post.find(favorites)
  end
end
