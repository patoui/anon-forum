class ReplyController < ApplicationController

  def create
    @post = Post.where(slug: params[:slug]).first or not_found
    @reply = Reply.new(post_id: @post.id, body: params[:body])
    if @reply.save
      record_activity(request, @reply)
      redirect_to "/thread/#{@post.slug}"
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

end
