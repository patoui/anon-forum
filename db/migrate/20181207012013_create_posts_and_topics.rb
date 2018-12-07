class CreatePostsAndTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :posts_topics do |t|
      t.belongs_to :post, index: true
      t.belongs_to :topic, index: true
    end
  end
end
