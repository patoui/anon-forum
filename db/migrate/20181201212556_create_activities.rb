class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name, index: true
      t.string :ip_address, index: true
      t.text :user_agent
      t.string :class_name
      t.integer :object_id
      t.timestamps
    end
  end
end
