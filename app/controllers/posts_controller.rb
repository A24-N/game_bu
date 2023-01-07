class PostsController < ApplicationController
  def index
    @npost = Post.new
    @posts = Post.all
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to posts_path
  end

  def show
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)

  end
end
