class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :slug
      t.index :slug
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
