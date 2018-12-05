class AddUpvoteCountToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :upvote_count, :integer, default: 0
  end
end
