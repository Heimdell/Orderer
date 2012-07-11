require 'state_machine'

class Story < ActiveRecord::Base
  include ActiveModel::Dirty
  include ActiveModel::Validations
  include ActiveModel::Observing

  attr_accessible :content, :state, :user_id, :worker_id

  belongs_to :user
  belongs_to :worker, :class_name => User, :foreign_key => 'worker_id'
  has_many   :story_comments

  validates_presence_of :user,    :on => :update
  validates_presence_of :content, :on => :update

  state_machine :state, :initial => :created do
    state :created, :value => 0
    state :started, :value => 1 do
      validates_presence_of :worker
    end

    state :finished, :value => 2 do
      validates_presence_of :worker
    end

    state :accepted, :value => 3 do
      validates_presence_of :worker
    end

    state :rejected, :value => 4 do
      validates_presence_of :worker
    end

    event :start do
      transition :created => :started
    end

    event :finish do
      transition :started => :finished
    end

    event :accept do
      transition :finished => :accepted
    end

    event :reject do
      transition :finished => :rejected
    end
  end

  def build_from(hash)
    self.user_id   = hash['user_id'].to_i
    self.worker_id = hash['worker_id'].to_i
    self.content   = hash['content']

    save

    self
  end

  def initialize
    super()

    self.state   = 0
  end
end
