include SessionsHelper

class Admin::AdminController < ApplicationController
#   http_basic_authenticate_with name: 'patoui', password: 'abc123'
  before_action :require_login

  private

  def require_login
    unless logged_in?
      redirect_to '/login'
    end
  end
end
