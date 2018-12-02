require 'test_helper'

class ReplyControllerTest < ActionDispatch::IntegrationTest

  test "can create a reply to a thread" do
    post = Post.create(title: 'My Thread with Comments', body: 'My thread body')

    get "/thread/#{post.slug}"

    assert_response :success
    assert_select 'h3', 'My Thread with Comments'
    assert_select 'div', 'My thread body'

    post "/thread/#{post.slug}/reply",
      params: { body: "This is a cool thread!" },
      headers: { 'HTTP_USER_AGENT': 'FAKE_REPLY_USER_AGENT' }

    assert_response :redirect

    follow_redirect!

    assert_response :success
    assert_select 'p', 'This is a cool thread!'
    assert_not_nil(
      Activity.where(
        user_agent: 'FAKE_REPLY_USER_AGENT',
        class_name: 'Reply'
      ).first
    )
  end

end
