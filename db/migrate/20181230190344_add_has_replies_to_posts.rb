class AddHasRepliesToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :has_replies, :boolean, null: false, default: true
  end
end
