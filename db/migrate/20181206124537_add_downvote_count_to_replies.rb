class AddDownvoteCountToReplies < ActiveRecord::Migration[5.2]
  def change
    add_column :replies, :downvote_count, :integer, default: 0
  end
end
