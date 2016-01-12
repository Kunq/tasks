class TasksController < ApplicationController
  def index
  	@task = Task.new
  	@tasks = Task.all
  end

  def create
  	#render :text => params.inspect
  	Task.create(task_params) # params[:task]
  	redirect_to :back
  end

  def edit
  	@task = Task.find params[:id]
  end

  def update
  	task = Task.find params[:id]
  	if task.update_attributes(task_params) 
  		redirect_to tasks_path, :success=> 'Your task has been sucessfully updated'
  	else
  		redirect_to :back, :notice => 'There was an error updating your task.'
  	end
  end

  def destroy
  	Task.destroy params[:id]
  	redirect_to :back, :notice => 'Task has been deleted'
  end

  def task_params
  	params.require(:task).permit(:task)
  end
end
