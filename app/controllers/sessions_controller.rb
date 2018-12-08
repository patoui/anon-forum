include SessionsHelper

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to '/dashboard'
    else
      render 'new'
    end
  end
end
