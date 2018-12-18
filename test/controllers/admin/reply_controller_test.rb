require 'test_helper'

class Admin::ReplyControllerTest < ActionDispatch::IntegrationTest
  test "can see replies" do
    php_thread = Post.create(title: 'My PHP Thread', body: 'PHP is interesting')
    php_reply_one = Reply.create(post_id: php_thread.id, body: 'PHP Reply One')
    php_reply_two = Reply.create(post_id: php_thread.id, body: 'PHP Reply Two')
    rails_thread = Post.create(title: 'My Rails Thread', body: 'Rails is interesting')
    rails_reply_one = Reply.create(post_id: rails_thread.id, body: 'Rails Reply One')
    rails_reply_two = Reply.create(post_id: rails_thread.id, body: 'Rails Reply Two')
    logInAdmin

    get '/admin/reply'

    assert_response :success
    assert_not_nil assigns(:replies)
    assert_select 'p.pre-wrap', 'PHP Reply One'
    assert_select 'p.pre-wrap', 'PHP Reply Two'
    assert_select 'p.text-muted', 'Thread: My PHP Thread'
    assert_select 'p.pre-wrap', 'Rails Reply One'
    assert_select 'p.pre-wrap', 'Rails Reply Two'
    assert_select 'p.text-muted', 'Thread: My Rails Thread'
    assert_select 'button', 'Delete'
  end

  test "can delete reply" do
    thread = Post.create(title: 'A Thread', body: 'A thread body')
    reply = Reply.create(post_id: thread.id, body: 'A reply')
    logInAdmin

    delete "/admin/reply/#{reply.id.to_s}"

    assert_nil(Reply.first)
    assert_not_nil(Reply.with_deleted.first)
  end
end
