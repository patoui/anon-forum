include ActivityHelper

class ReplyUpvoteController < ApplicationController
  before_action CheckThrottle, only: :create

  def create
    @post = Post.find_by(slug: params[:slug]) or not_found
    @reply = Reply.find(params[:id]) or not_found
    @reply.increment!(:upvote_count)
    record_activity('upvoted-reply', request, @reply)
    redirect_to "/thread/#{@post.slug}"
  end
end
