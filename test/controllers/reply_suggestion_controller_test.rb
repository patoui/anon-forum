require 'test_helper'

class ReplySuggestionControllerTest < ActionDispatch::IntegrationTest
  test "can see list of reply suggestions" do
    thread = Post.create(title: 'My Rails Thread', body: 'Rails is interesting')
    reply_one = Reply.create(post_id: thread.id, body: 'Rails Reply One')
    reply_two = Reply.create(post_id: thread.id, body: 'Rails Reply Two')

    get "/thread/#{thread.slug}/reply-suggestion?q=@#{reply_one.slug}", xhr: true

    assert_response :success
    assert_equal [reply_one.slug].to_s.gsub(/\s+/, ''), @response.body
  end
end
