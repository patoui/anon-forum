include ActivityHelper

class ReplyController < ApplicationController
  before_action CheckThrottle, only: :create

  def create
    @post = Post.where(slug: params[:slug]).first or not_found
    if !@post.has_replies then not_found end
    @reply = Reply.new(post_id: @post.id, body: params[:body])

    if @reply.save
      record_activity('created-reply', request, @reply)
    else
      flash[:reply_errors] = @reply.errors.full_messages
    end

    redirect_to post_show_path(@post.slug)
  end

end
