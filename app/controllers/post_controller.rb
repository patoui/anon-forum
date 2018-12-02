include ActivityHelper

class PostController < ApplicationController
  before_action CheckThrottle, only: :create

  def index
    @posts = params[:q].present? ?
      Post.where('title LIKE ?', "%#{params[:q]}%") :
      Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(title: params[:title], body: params[:body])
    if @post.save
      record_activity(request, @post)
      redirect_to action: 'index' and return
    else
      render 'new'
    end
  end

  def show
    @post = Post.where(slug: params[:slug]).first
  end

end
