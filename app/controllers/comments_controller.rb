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

  def vote_up
    vote 1
  end

  def vote_down
    vote -1
  end

  def mark_as_not_abusive
    comment.update_attributes abusive: false, marked_as_not_abusive: true
    redirect_to post
  end

  private

  def vote(value)
    vote = comment.votes.new value: value, user: current_user
    if vote.save
      redirect_to post
    else
      redirect_to post, alert: "You can't vote twice!"
    end
  end

  def comment_params
    params.require(:comment).permit(:body) if %w{create}.include? action_name
  end
end