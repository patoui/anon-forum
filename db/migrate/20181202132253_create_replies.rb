class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.belongs_to :post, index: true, null: false
      t.text :body
      t.timestamps
    end
  end
end
