class CommentsController < ApplicationController
  #cancancanによる権限確認
  load_and_authorize_resource

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to request.referer, notice: "送信しました:)"
    else
      flash[:alert]= @comment.errors.full_messages.join(',')
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
