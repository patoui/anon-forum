class ReplySuggestionController < ApplicationController
  def index
    post = Post.find_by(slug: params[:slug]) or not_found
    render json: post.replies
      .where('slug like ?', "#{params[:q].tr('@','')}%")
      .pluck(:slug)
  end
end
