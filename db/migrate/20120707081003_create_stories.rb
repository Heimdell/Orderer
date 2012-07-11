class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.string :content
      t.integer :worker_id
      t.integer :state

      t.timestamps
    end
  end
end
