require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "can see stats" do
    for i in 1..34
      post = Post.create(title: "title#{i}", body: 'body')
    end
    for i in 1..45
      post.replies.create(body: 'A reply')
    end
    logInAdmin

    get '/dashboard'

    assert_response :success
    assert_select 'h1', 'Dashboard'
    assert_select 'p.card-text', '34'
    assert_select 'p.card-text', '45'
  end

  private
  def logInAdmin
    User.create(email: 'patrique.ouimet@gmail.com', password: 'abc123')
    post '/login', params: {
      email: 'patrique.ouimet@gmail.com',
      password: 'abc123'
    }

    assert_response :redirect

    follow_redirect!

    assert_response :success
  end
end
