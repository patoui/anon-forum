include ActivityHelper

class PostController < ApplicationController
  before_action CheckThrottle, only: :create

  def index
    page = params[:page].present? ? params[:page] : 1
    @search = params[:q]
    @posts = Post.search(@search).paginate(:page => page)
    @popularTags = Tag.popular
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      record_activity('created-post', request, @post)
      @post.addTags(params[:tags])
      redirect_to root_path
    else
      redirect_to post_new_path, :flash => { :post_errors => @post.errors }
    end
  end

  def show
    @post = Post.find_by(slug: params[:slug])
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :has_replies)
  end

end
