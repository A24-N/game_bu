class FavoritesController < ApplicationController
  #cancancanによる権限確認(favoriteは除外)
  load_and_authorize_resource only: [:create, :destroy]

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
    @posts = Kaminari.paginate_array(Post.find(favorites)).page(params[:page]).per(6)
  end
end
