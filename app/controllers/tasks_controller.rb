class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # TODO: SearchとSortを同時に行えるようにする
  def index
    @tasks = Task.user_tasks(current_user.id)
    @tasks = @tasks.sort_tasks(sort_column_params, sort_direction_params) if params[:sort_column] && params[:sort_direction]
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

    def sort_column_params
      Task.column_names.include?(params[:sort_column]) ? params[:sort_column] : nil
    end

    def sort_direction_params
      %w(asc desc).include?(params[:sort_direction]) ? params[:sort_direction] : nil
    end

    def search_tasks
      @tasks = @tasks.search_tasks('title', params[:search_title]) if params[:search_title].present?
      @tasks = @tasks.search_tasks('status', params[:search_status]) if params[:search_status].present?
      @tasks = @tasks.search_tasks('priority', params[:search_priority]) if params[:search_priority].present?
    end
end
