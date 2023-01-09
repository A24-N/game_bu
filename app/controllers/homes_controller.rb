class HomesController < ApplicationController
  def top
    @npost = Post.new
    @posts = Post.order(created_at: "DESC").limit(3)
  end

  def about
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
