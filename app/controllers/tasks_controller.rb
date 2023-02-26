class TasksController < ApplicationController

  before_action :params_task, only: [:create, :update]
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @task_page = current_user.tasks.order(created_at: :desc).page(params[:page])
    @query = @task_page.ransack(params[:q])
    @tasks = @query.result(distinct: true)

  end

  def new    
    @task = current_user.tasks.new   
    @submit_button = t('forms.submit_create', default: 'Create')
  end


  def create
    # render html: params
    @task = current_user.tasks.new(params_task)  

    if @task.save      
      redirect_to root_path, notice: "成功新增任務"
    else
      render :new      
    end
  end

  def show
  end

  def edit
    @submit_button = t('forms.submit_update', default: 'Update')
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
    @task = current_user.tasks.find(params[:id])
  end  
  
end