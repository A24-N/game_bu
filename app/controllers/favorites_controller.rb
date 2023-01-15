class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    post_favorite = Favorite.new(user_id: current_user.id, post_id: @post.id)
    post_favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    post_favorite = Favorite.find_by(user_id: current_user.id, post_id: @post.id)
    post_favorite.destroy
  end

  def favorite
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @posts = Post.find(favorites)
  end
end
