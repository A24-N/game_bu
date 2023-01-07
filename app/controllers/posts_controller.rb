class PostsController < ApplicationController
  def index
    @npost = Post.new
    @post = Post.all
  end

  def create
  end

  def show
  end

  def edit
  end
end
