class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:main, :about]

  def top
    @npost = Post.new
    @posts = Post.order(created_at: "DESC").limit(3)
  end

  def main
  end

  def about
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
