class Admin::PostsController < Admin::ApplicationController
  def index
    @user = params[:user_id]
    if @user_id.blank?
      @posts = Post.preload(:user, :tags).all
    else
      @posts = Post.preload(:user, :tags).where(user_id: @user_id)
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to admin_posts_path, notice: "投稿を削除しました"
    else
      redirect_to request.referer, alert: "投稿を削除できませんでした"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    @tags = @post.tags
  end
end
