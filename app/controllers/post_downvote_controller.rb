include ActivityHelper

class PostDownvoteController < ApplicationController
  before_action CheckThrottle, only: :create

  def create
    @post = Post.find_by(slug: params[:slug]) or not_found
    @post.increment!(:downvote_count)
    record_activity('downvoted-post', request, @post)
    redirect_to "/thread/#{@post.slug}"
  end
end
