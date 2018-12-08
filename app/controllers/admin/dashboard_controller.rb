class Admin::DashboardController < Admin::AdminController
  def index
    @postsCount = Post.count
    @repliesCount = Reply.count
  end
end
