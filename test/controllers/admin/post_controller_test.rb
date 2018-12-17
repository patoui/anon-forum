require 'test_helper'

class Admin::PostControllerTest < ActionDispatch::IntegrationTest
  test "can see threads" do
    php_thread = Post.create(title: 'My PHP Thread', body: 'PHP is interesting')
    php_thread.tags << Tag.find_or_create_by(name: 'php_is_neat')
    rails_thread = Post.create(title: 'My Rails Thread', body: 'Rails is also interesting')
    rails_thread.tags << Tag.find_or_create_by(name: 'rails_is_neat')
    logInAdmin

    get '/admin/thread'

    assert_response :success
    assert_not_nil assigns(:posts)
    assert_select 'h5', 'My PHP Thread'
    assert_select 'a', '#php_is_neat'
    assert_select 'h5', 'My Rails Thread'
    assert_select 'a', '#rails_is_neat'
    assert_select 'button', 'Delete'
  end

  test "can delete thread" do
    thread = Post.create(title: 'A Thread', body: 'A thread body')
    logInAdmin

    delete "/admin/thread/#{thread.id.to_s}"

    assert_nil(Post.first)
    assert_not_nil(Post.with_deleted.first)
  end
end
