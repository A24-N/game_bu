class PostsController < ApplicationController
  def index
    @npost = Post.new
    @posts = Post.all
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to post_path(post.id)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
