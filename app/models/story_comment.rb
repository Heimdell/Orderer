class StoryComment < ActiveRecord::Base
  attr_accessible :content, :story_id, :user_id

  belongs_to :user
  belongs_to :story

  validates_presence_of :user
  validates_presence_of :story
  validates_presence_of :content

  def build_from(hash)
    self.content = hash['content']
    self.story   = Story.find hash['story_id'].to_i
    self.user    = User.find  hash['user_id'].to_i

    if ! save
    then
      print 'DIED\n'
    end

    self
  end
end
