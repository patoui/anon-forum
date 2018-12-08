module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    return !session[:user_id].nil?
  end
end
