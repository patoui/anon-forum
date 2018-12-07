require 'test_helper'

class PostControllerTest < ActionDispatch::IntegrationTest
  test "can see threads" do
    php_thread = Post.create(title: 'My PHP Thread', body: 'PHP is interesting')
    php_thread.tags << Tag.find_or_create_by(name: 'php_is_neat')
    rails_thread = Post.create(title: 'My Rails Thread', body: 'Rails is also interesting')
    rails_thread.tags << Tag.find_or_create_by(name: 'rails_is_neat')

    get '/'

    assert_response :success
    assert_not_nil assigns(:posts)
    assert_select 'h5', 'My PHP Thread'
    assert_select 'a', '#php_is_neat'
    assert_select 'h5', 'My Rails Thread'
    assert_select 'a', '#rails_is_neat'
  end

  test "can search threads" do
    php_thread = Post.create(title: 'My PHP Thread', body: 'PHP is interesting')
    rails_thread = Post.create(title: 'My Rails Thread', body: 'Rails is also interesting')

    get '/?q=rails'

    assert_response :success
    assert_select 'h5', 'My Rails Thread'
    assert_select 'h5', { :count => 1 }
  end

  test "can see new thread form" do
    get '/thread/new'

    assert_response :success
    assert_select 'label', 'Tags'
  end

  test "can create a thread" do
    get "/thread/new"

    assert_response :success

    post "/thread",
      params: {
        post: {
          title: "My New Thread",
          body: "The body of my new thread"
        },
        tags: [ 'rubyonrails' ]
      },
      headers: { 'HTTP_USER_AGENT': 'FAKE_USER_AGENT' }

    assert_response :redirect

    follow_redirect!

    assert_response :success
    assert_select 'a', 'My New Thread'
    assert_not_nil(
      Activity.where(
        name: 'created-post',
        user_agent: 'FAKE_USER_AGENT',
        class_name: 'Post'
      ).first
    )
    assert_not_nil(Tag.find_by(name: 'rubyonrails'))
  end

  test "can see a thread" do
    post = Post.create(title: 'My Thread', body: 'My thread body')
    Reply.create(post_id: post.id, body: 'First reply')

    get "/thread/#{post.slug}"

    assert_response :success
    assert_select 'h3', 'My Thread'
    assert_select 'p', 'My thread body'
    assert_select 'p', 'First reply'
  end
end
