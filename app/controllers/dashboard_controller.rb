include SessionsHelper

class DashboardController < ApplicationController
  before_action :require_login

  def index
    @postsCount = Post.count
    @repliesCount = Reply.count
  end

  private

  def require_login
    unless logged_in?
      redirect_to '/login'
    end
  end
end
