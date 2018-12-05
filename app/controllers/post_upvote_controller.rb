include ActivityHelper

class PostUpvoteController < ApplicationController
  def create
    @post = Post.find_by(slug: params[:slug]) or not_found
    @post.increment!(:upvote_count)
    record_activity('upvoted-post', request, @post)
    redirect_to "/thread/#{@post.slug}"
  end
end
