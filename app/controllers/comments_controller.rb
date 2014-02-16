class CommentsController < ApplicationController
  before_filter :authenticate_user!

  expose(:post)
  expose(:comment, attributes: :comment_params)
  expose(:comments, ancestor: :post)

  def create
    comment.user = current_user
    if comment.save
      redirect_to post
    else
      redirect_to post, notice: "Your comment couldn't be added. You probably didn't write anything."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end