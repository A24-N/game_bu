class Admin::PostsController < Admin::ApplicationController
  def index
    @user = params[:user_id]
    if @user_id.blank?
      @posts = Post.all
    else
      @posts = Post.where(user_id: @user_id)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    @tags = @post.tags
  end
end
