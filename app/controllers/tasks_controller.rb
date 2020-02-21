class TasksController < ApplicationController
  protect_from_forgery except: [:create, :update]
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    render json: { status: 'SUCCESS', message: 'Loaded tasks', data: @tasks }
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the task', data: @task }
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: { status: 'SUCCESS', message: 'Created the task', data: @task }
    else
      render json: { status: 'ERROR', data: @task.errors }, status: :bad_request
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      render json: { status: 'SUCCESS', message: 'Updated the task', data: @task }
    else
      render json: { status: 'ERROR', data: @task.errors }, status: :bad_request
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the task', data: @task }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title)
    end
end
