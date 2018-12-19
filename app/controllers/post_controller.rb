include ActivityHelper

class PostController < ApplicationController
  before_action CheckThrottle, only: :create

  def index
    page = params[:page].present? ? params[:page] : 1
    @posts = Post.search(params[:q]).paginate(:page => page)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      record_activity('created-post', request, @post)
      @post.addTags(params[:tags])
      redirect_to action: 'index' and return
    else
      render 'new'
    end
  end

  def show
    @post = Post.find_by(slug: params[:slug])
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

end
