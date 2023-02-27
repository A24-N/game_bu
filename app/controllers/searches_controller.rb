class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      if @word.blank?
        @users = User.where("nickname LIKE?", "")
      else
        @users = User.where("nickname LIKE?", "%#{@word}%")
      end
    elsif @range == "Post"
      if @word.blank?
         @posts = Post.preload(:user).includes([:tags]).where("title LIKE?", "")
      else
        @posts = Post.preload(:user).includes([:tags]).where("title LIKE?", "%#{@word}%")
      end
    elsif @range == "Tag"
      @posts = Post.joins(:tags).where("name LIKE?", "#{@word}")
    elsif @range == "UserPosts"
      @posts =Post.includes([:user]).includes([:tags]).where(user_id: params[:id])
    end
  end
end
