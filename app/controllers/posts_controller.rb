class PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @npost = Post.new
    @posts = Post.order("created_at DESC").page(params[:page]).per(6)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to post_path(@post.id), notice: "投稿しました:)"
    else
      redirect_to request.referer, alert: "投稿に失敗しました:<"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    @tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',')
  end

  def update
    post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if post.update(post_params)
      post.save_tag(tag_list)
      redirect_to post_path(post)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to main_path, alert: "アクセス権限がありません:<"
    end
  end
end
