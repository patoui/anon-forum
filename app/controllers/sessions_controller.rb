include SessionsHelper

class SessionsController < ApplicationController
  http_basic_authenticate_with name: "patoui", password: "abc123"

  def new
  end

  def create
    if !params[:email].nil? && params[:email].downcase === 'patrique.ouimet@gmail.com'
      user = User.find_by(email: params[:email].downcase)
      if user && user.authenticate(params[:password])
        log_in user
        redirect_to '/admin/dashboard' and return
      end
    end

    render 'new'
  end

  def destroy
    log_out
    redirect_to '/'
  end
end
