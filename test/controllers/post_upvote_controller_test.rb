require 'test_helper'

class PostUpvoteControllerTest < ActionDispatch::IntegrationTest
    test "can upvote a thread" do
    thread = Post.create(title: 'My Thread', body: 'My thread body')

    post "/thread/#{thread.slug}/upvote",
      headers: { 'HTTP_USER_AGENT': 'FAKE_UPVOTE_USER_AGENT' }

    assert_response :redirect
    assert_not_nil(
      Activity.where(
        name: 'upvoted-post',
        user_agent: 'FAKE_UPVOTE_USER_AGENT',
        class_name: 'Post'
      ).first
    )
    assert_not_nil(
      Post.where(
        title: 'My Thread',
        body: 'My thread body',
        upvote_count: 1
      ).first
    )
  end
end
