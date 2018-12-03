class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.includes(:task_labels)
    @tasks = @tasks.sort_tasks(params[:sort_column], params[:sort_direction])
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
      flash[:success] = 'タスクを作成しました。'
      redirect_to tasks_path
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクを更新しました。'
      labels = params[:label_title].split(",")
      @task.save_labels(labels)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_to tasks_path
  end

  private

    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :deadline, :status, :priority)
    end

    def search_tasks
      @tasks = @tasks.includes(:task_labels).search_tasks('title', params[:search_title]) if params[:search_title].present?
      @tasks = @tasks.search_tasks('status', params[:search_status]) if params[:search_status].present?
      @tasks = @tasks.search_tasks('priority', params[:search_priority]) if params[:search_priority].present?
    end
end
