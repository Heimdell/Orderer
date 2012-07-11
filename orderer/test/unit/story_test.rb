require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user, @worker = User.new, User.new

    @user.email = 'test@test.fr'
    @user.password = '12435'

    @worker.email = '1@2.3'
    @worker.password = 'asdasdas'

    @story, @story2 = Story.new, Story.new

    @story.user = @user
    @story.content = 'adasdas'
    @story.save

    @story2.user = @worker
    @story2.content = 'asdsaas'
    @story2.save
  end

  test "Is story created?" do
    assert @story.instance_of?(Story)
  end

  test "Blank cannot save?" do
    @story.content = ''
    @story.user    = nil

    assert ! @story.save, "Totally blank story is saved"

    @story.user = @user

    assert ! @story.save, "Story with blank content is saved"

    @story.user = nil
    @story.content = 'adasasd'

    assert ! @story.save, "Story without a creator saved"

    @story.user = @user

    assert @story.save, "Valid story is not saved"
  end

  test "state machine" do
    assert @story.created?, "Story state is initially corrupted"

    assert ! @story.start, "Story started w/o a worker"

    @story.worker = @worker

    assert @story.start, "Story does'nt start with a worker"

    assert @story.started?, "Story state must be a #{:started.to_s} but is an #{@story.state_name}"

    assert @story.finish, "Story is started, but cannot finish"

    assert @story.finished?, "Story state must begin a #{:finished.to_s} but is an #{@story.state_name}"

    assert @story.accept, "Story is finished, but cannot be accepted"

    assert @story.accepted?, "Story state must begin a #{:accepted.to_s} but is an #{@story.state_name}"

    @story2.worker = @user

    @story2.start
    @story2.finish

    assert @story2.reject, "Story2 is #{@story2.state_name}, and cannot be rejected"

    assert @story2.rejected?, "Story2 state must begin a #{:rejected.to_s} but is an #{@story.state_name}"
  end

  teardown do
    @story.delete
    @story2.delete
  end
end
