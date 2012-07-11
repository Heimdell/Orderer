class CreateStoryComments < ActiveRecord::Migration
  def change
    create_table :story_comments do |t|
      t.integer :story_id
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
