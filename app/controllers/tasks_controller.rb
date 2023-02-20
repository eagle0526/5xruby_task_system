class TasksController < ApplicationController

  before_action :params_task, only: [:create, :update]
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    # render html: params
    @task = Task.new(params_task)
    # user = User.first
    
    # 先這樣設定，之後要刪掉
    # @task.user_id = user.id

    if @task.save
      
      redirect_to root_path, notice: "成功新增任務"
    else
      render :new      
    end
  end

  def show
  end

  def edit

  end

  def update

    if @task.update(params_task)
      redirect_to tasks_path, notice: "成功更新任務"
    else
      render :edit
    end

  end

  def destroy
    @task.destroy

    redirect_to tasks_path, alert: "刪掉任務"
  end

  private

  def params_task
    params.require(:task).permit(:title, :content, :priority, :state, :classification, :start_time, :end_time, :user_id)
  end

  def find_task
    @task = Task.find(params[:id])
  end  
  
end