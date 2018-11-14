module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find(user_id)
    end
  end

  def current_user?(user)
    user == current_user
  end

  def log_out
    session.delete(:user_id)
  end
end
