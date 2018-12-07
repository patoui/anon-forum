class CreatePostsAndTags < ActiveRecord::Migration[5.2]
  def change
    create_table :posts_tags do |t|
      t.belongs_to :post, index: true
      t.belongs_to :tag, index: true
    end
  end
end
