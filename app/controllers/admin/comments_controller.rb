class Admin::CommentsController < Admin::ApplicationController
  def destroy
    @post = Post.find(params[:post_id])
    if Comment.find(params[:id]).destroy
      redirect_to request.referer, notice: "コメントを削除しました"
    else
      redirect_to request.referer, alert: "コメントを削除できませんでした"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
