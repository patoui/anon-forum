class CreateAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :associations do |t|
      t.belongs_to :post, index: true
      t.belongs_to :tag, index: true
      t.timestamps
    end
  end
end
