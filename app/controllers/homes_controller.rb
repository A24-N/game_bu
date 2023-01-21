class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top, :about]

  def top
  end

  def main
    @npost = Post.new
    @posts = Post.order(created_at: "DESC").limit(3)
    @match = Match.find_by(user_id: current_user.id)
  end

  def about
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
