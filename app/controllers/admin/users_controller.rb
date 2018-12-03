class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_users, except: [:show, :new, :edit]
  before_action :administrator_required

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_url, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_url, notice: 'User was successfully destroyed.'
    else
      redirect_to admin_users_url, notice: 'Failed. The user is the last one administrator.'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_users
      @users = User.all
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def administrator_required
      redirect_to root_url unless current_user.admin?
    end
end
