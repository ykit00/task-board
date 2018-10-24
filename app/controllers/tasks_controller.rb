class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = sort_tasks
    @tasks = @tasks.search_by_title params[:title] if params[:title].present?
    @tasks = @tasks.search_by_status params[:status] if params[:status].present?
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
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
      params.require(:task).permit(:title, :description, :deadline)
    end

    def sort_tasks
      if params[:deadline].present? && params[:deadline] == "asc"
        Task.all.sort_by_deadline_asc
      else
        Task.all.sort_by_created_at_desc
      end
    end
end
