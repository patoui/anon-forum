include ActivityHelper

class PostController < ApplicationController
  before_action :check_throttle, only: :create

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
    @post = Post.where(slug: params[:slug]).take
  end

  private

  def check_throttle
    activityCount = Activity.where(ip_address: request.remote_ip)
      .where(created_at: (Time.now.ago(300))..Time.now)
      .count

    if activityCount >= 5
      flash[:error] = "You've exhausted your activity limit."
      redirect_to action: 'index' and return
    end
  end

end
