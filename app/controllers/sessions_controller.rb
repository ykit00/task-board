class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to tasks_path
      flash[:success] = 'ログインしました。'
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが正しくありません。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
