class Admin::ReplyController < ApplicationController
  def index
    page = params[:page].present? ? params[:page] : 1
    @replies = Reply.paginate(:page => page)
  end

  def destroy
    reply = Reply.find(params[:id]) or not_found
    reply.destroy
    redirect_to '/admin/reply'
  end
end
