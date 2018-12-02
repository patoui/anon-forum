require 'test_helper'

class PostControllerTest < ActionDispatch::IntegrationTest

  test "can see threads" do
    get '/'

    assert_response :success
    assert_equal Post.all, assigns(:posts)
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
  end

  test "can create a thread" do
    get "/thread/new"

    assert_response :success

    post "/thread",
      params: { title: "My New Thread", body: "The body of my new thread" },
      headers: { 'HTTP_USER_AGENT': 'FAKE_USER_AGENT' }

    assert_response :redirect

    follow_redirect!

    assert_response :success
    assert_select "a", "My New Thread"
    assert_not_nil(
      Activity.where(
        user_agent: 'FAKE_USER_AGENT',
        class_name: 'Post'
      ).first
    )
  end

  test "can see a thread" do
    post = Post.create(title: 'My Thread', body: 'My thread body')

    get "/thread/#{post.slug}"

    assert_response :success
    assert_select 'h3', 'My Thread'
    assert_select 'div', 'My thread body'
  end

end
