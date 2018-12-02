class ReplyController < ApplicationController
  before_action CheckThrottle, only: :create

  def create
    @post = Post.where(slug: params[:slug]).first or not_found
    @reply = Reply.new(post_id: @post.id, body: params[:body])
    if @reply.save
      record_activity(request, @reply)
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to "/thread/#{@post.slug}"
  end

end
