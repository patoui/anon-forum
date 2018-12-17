class Admin::PostController < ApplicationController
  def index
    page = params[:page].present? ? params[:page] : 1
    @posts = params[:q].present? ?
      Post.where('title LIKE ?', "%#{params[:q]}%").paginate(:page => page) :
      Post.paginate(:page => page)
  end

  def destroy
    post = Post.find(params[:id]) or not_found
    post.destroy
    redirect_to '/admin/thread'
  end
end
