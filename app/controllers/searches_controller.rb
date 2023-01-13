class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    elsif @range == "Post"
      @posts = Post.looks(params[:search], params[:word])
    elsif @range == "Tag"
      @word = params[:word]
      @books = Book.joins(:tags).where("name LIKE?", "#{@word}")
    end
  end
end
