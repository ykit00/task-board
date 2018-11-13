class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  def index
    @tasks = sort_tasks
    search_tasks
    @tasks = @tasks.page params[:page]
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクを作成しました。'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました。'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :deadline, :status, :priority)
    end

    def sort_tasks
      if params[:sort_deadline].present? && params[:sort_deadline] == "asc"
        Task.all.sort_by_deadline_asc
      elsif params[:sort_deadline].present? && params[:sort_deadline] == "desc"
        Task.all.sort_by_deadline_desc
      elsif params[:sort_created_at].present? && params[:sort_created_at] == "asc"
        Task.all.sort_by_created_at_asc
      elsif params[:sort_created_at].present? && params[:sort_created_at] == "desc"
        Task.all.sort_by_created_at_desc
      elsif params[:sort_priority].present? && params[:sort_priority] == "asc"
        Task.all.sort_by_priority_asc
      elsif params[:sort_priority].present? && params[:sort_priority] == "desc"
        Task.all.sort_by_priority_desc
      else
        Task.all.sort_by_created_at_desc
      end
    end

    def search_tasks
      @tasks = @tasks.search_by_title params[:search_title] if params[:search_title].present?
      @tasks = @tasks.search_by_status params[:search_status] if params[:search_status].present?
      @tasks = @tasks.search_by_priority params[:search_priority] if params[:search_priority].present?
    end

end
