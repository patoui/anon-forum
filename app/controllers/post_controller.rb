class PostController < ApplicationController

  def index

    @posts = Post.all

    render 'index'

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

    @post = Post.find(params[:id])

    render 'show'

  end

end
