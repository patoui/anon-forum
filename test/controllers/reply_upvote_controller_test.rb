require 'test_helper'

class ReplyUpvoteControllerTest < ActionDispatch::IntegrationTest
    test "can upvote a reply" do
    thread = Post.create(title: 'My Thread', body: 'My thread body')
    reply = Reply.create(post_id: thread.id, body: 'My reply body')

    post "/thread/#{thread.slug}/reply/#{reply.id}/upvote",
      headers: { 'HTTP_USER_AGENT': 'FAKE_REPLY_UPVOTE_USER_AGENT' }

    assert_response :redirect
    assert_not_nil(
      Activity.where(
        name: 'upvoted-reply',
        user_agent: 'FAKE_REPLY_UPVOTE_USER_AGENT',
        class_name: 'Reply'
      ).first
    )
    assert_not_nil(
      Reply.where(
        post_id: thread.id,
        body: 'My reply body',
        upvote_count: 1
      ).first
    )
  end
end

