require 'test_helper'

class PostControllerTest < ActionDispatch::IntegrationTest

  test "can see threads" do

    get '/'

    assert_response :success

    assert_not_nil assigns(:posts)

  end

  test "can see new thread form" do

    get '/thread/new'

    assert_response :success

  end

  test "can create a thread" do

    get "/thread/new"

    assert_response :success

    post "/thread",
      params: { title: "My New Thread", body: "The body of my new thread" }

    assert_response :redirect

    follow_redirect!

    assert_response :success

    assert_select "a", "My New Thread"

  end

end
