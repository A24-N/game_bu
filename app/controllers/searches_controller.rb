class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @users = User.where("nickname LIKE?", "%#{@word}%")
    elsif @range == "Post"
      @posts = Post.where("title LIKE?", "%#{@word}%")
    elsif @range == "Tag"
      @posts = Post.joins(:tags).where("name LIKE?", "#{@word}")
    end
  end
end
