class PostController < ApplicationController

  def index

    @posts = Post.all

  end

  def new

    @post = Post.new

    render 'new'

  end

  def create

    @post = Post.new(title: params[:title], body: params[:body])

    if @post.save

      redirect_to action: 'index' and return

    else

      render 'new'

    end

  end

  def show

    @post = Post.where(slug: params[:slug]).take

    render 'show'

  end

end
