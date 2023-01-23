class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @users = User.where("nickname LIKE?", "%#{@word}%")
    elsif @range == "Post"
      @posts = Post.preload(:user).includes([:tags]).where("title LIKE?", "%#{@word}%")
    elsif @range == "Tag"
      @posts = Post.joins(:tags).where("name LIKE?", "#{@word}")
    elsif @range == "UserPosts"
      @posts =Post.includes([:user]).includes([:tags]).where(user_id: params[:id])
    end
  end
end
