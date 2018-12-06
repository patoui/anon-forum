require 'test_helper'

class PostDownvoteControllerTest < ActionDispatch::IntegrationTest
    test "can downvote a thread" do
    thread = Post.create(title: 'My Thread', body: 'My thread body')

    post "/thread/#{thread.slug}/downvote",
      headers: { 'HTTP_USER_AGENT': 'FAKE_UPVOTE_USER_AGENT' }

    assert_response :redirect
    assert_not_nil(
      Activity.where(
        name: 'downvoted-post',
        user_agent: 'FAKE_UPVOTE_USER_AGENT',
        class_name: 'Post',
        object_id: thread.id
      ).first
    )
    assert_not_nil(
      Post.where(
        title: 'My Thread',
        body: 'My thread body',
        downvote_count: 1
      ).first
    )
  end
end
