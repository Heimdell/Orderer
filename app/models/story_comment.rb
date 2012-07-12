class StoryComment < ActiveRecord::Base
  attr_accessible :content, :story_id, :user_id

  belongs_to :user
  belongs_to :story

  validates_presence_of :user
  validates_presence_of :story
  validates_presence_of :content
end
