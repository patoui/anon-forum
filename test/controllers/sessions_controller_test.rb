require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "can see login form" do
    get '/login'

    assert_response :success
    assert_select 'label', 'Email'
    assert_select 'label', 'Password'
  end

  test "can log in" do
    User.create(email: 'patrique.ouimet@gmail.com', password: 'abc123')

    post '/login', params: {
      email: 'patrique.ouimet@gmail.com',
      password: 'abc123'
    }

    assert_response :redirect

    follow_redirect!

    assert_response :success
    assert_select 'h1', 'Dashboard'
    assert session[:user_id]
  end
end
