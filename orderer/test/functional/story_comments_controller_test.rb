require 'test_helper'

class StoryCommentsControllerTest < ActionController::TestCase
  setup do
    @story         = stories(:one)
    @story_comment = story_comments(:one)
    @user          = users(:two)
    
    @story_comment.user  = @user
    @story_comment.story = @story
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:story_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create story_comment" do
    assert_difference('StoryComment.count') do
      post :create, :story_comment => { :content => @story_comment.content, :story_id => @story_comment.story_id, :user_id => @story_comment.user_id }
    end

    assert_redirected_to story_comment_path(assigns(:story_comment))
  end

  test "should show story_comment" do
    get :show, :id => @story_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @story_comment
    assert_response :success
  end

  test "should update story_comment" do
    put :update, :id => @story_comment, :story_comment => { :content => @story_comment.content, :story_id => @story_comment.story_id, :user_id => @story_comment.user_id }
    assert_redirected_to story_comment_path(assigns(:story_comment))
  end

  test "should destroy story_comment" do
    assert_difference('StoryComment.count', -1) do
      delete :destroy, :id => @story_comment
    end

    assert_redirected_to story_comments_path
  end
end
