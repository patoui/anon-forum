class AddIndexToPostsTopics < ActiveRecord::Migration[5.2]
  def change
    add_index :posts_topics, [:post_id, :topic_id], :unique => true
  end
end
