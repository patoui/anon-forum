ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def logInAdmin
    #@request.headers['Authorization'] = ActionController::HttpAuthentication::Basic.encode_credentials('patoui', 'abc123')
    #@request.env['HTTP_AUTHORIZATION'] = "Basic #{ActiveSupport::Base64.encode64("patoui:abc123")}"
    # @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('patoui', 'abc123')
    # request.headers['Authorization'] = ActionController::HttpAuthentication::Basic.encode_credentials('patoui', 'abc123')
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
