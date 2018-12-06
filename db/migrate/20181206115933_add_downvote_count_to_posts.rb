class AddDownvoteCountToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :downvote_count, :integer, default: 0
  end
end
