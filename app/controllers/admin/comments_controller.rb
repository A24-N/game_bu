class Admin::CommentsController < Admin::ApplicationController

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
