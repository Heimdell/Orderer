
class Story < ActiveRecord::Base
  attr_accessible :content, :state, :user_id, :worker_id

  belongs_to :user
  belongs_to :worker, :class_name => User, :foreign_key => 'worker_id'
  has_many   :story_comments

  validates_presence_of :user,    :on => :update
  validates_presence_of :content, :on => :update

  state_machine :state, :initial => :created do
    state :created
    state :started do
      validates_presence_of :worker
    end

    state :finished do
      validates_presence_of :worker
    end

    state :accepted do
      validates_presence_of :worker
    end

    state :rejected do
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
  
  def available_transitions
    transitions = {}
    
    transitions[:accept] = true if can_accept?
    transitions[:finish] = true if can_finish?
    transitions[:reject] = true if can_reject?
    transitions[:start]  = true if can_start?
    
    transitions
  end
end
