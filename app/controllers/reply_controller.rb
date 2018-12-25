include ActivityHelper

class ReplyController < ApplicationController
  before_action CheckThrottle, only: :create

  def create
    @post = Post.where(slug: params[:slug]).first or not_found
    @reply = Reply.new(post_id: @post.id, body: params[:body])

    if @reply.save
      record_activity('created-reply', request, @reply)
      redirect_to post_show_path(@post.slug)
    else
      flash[:reply_errors] = @reply.errors.full_messages
      redirect_to post_show_path(@post.slug)
    end
  end

end
