class AddUpvoteCountToReplies < ActiveRecord::Migration[5.2]
  def change
    add_column :replies, :upvote_count, :integer, default: 0
  end
end
