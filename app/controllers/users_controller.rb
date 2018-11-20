class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user_required, only: [:show, :edit, :update, :destroy]
  skip_before_action :login_required, only: [:new, :create]


  # 管理者ユーザー作成後に有効化する
  # def index
  #   @users = User.all.page params[:page]
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録が完了しました。"
      log_in @user
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def current_user_required
      redirect_to current_user unless current_user?(@user)
    end
end
