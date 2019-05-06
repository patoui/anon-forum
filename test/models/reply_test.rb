require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  test "generates slug" do
    post = Post.create(title: 'My Thread', body: 'My thread body')
    reply = Reply.create(post_id: post.id, body: 'First reply')

    assert_not_nil reply.slug
  end
end
