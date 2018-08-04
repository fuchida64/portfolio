class TasksController < ApplicationController

	def create
		@task = Task.new(task_params)
		@task.task_group_id = params[:group_id]
		if @task.save
			redirect_to task_group_path(id: params[:group_id])
		end
	end

	def update
		@task = Task.find(params[:id])
		if @task.update(task_params)
			redirect_to task_group_path(@task.task_group_id)
		end
	end

	def check
		@task = Task.find(params[:id])
		if @task.update(:status => @task.status + 1)
			redirect_to task_group_path(@task.task_group_id)
		end
	end

	def destroy
		@task = Task.find(params[:id])
		if @task.destroy
		  redirect_to task_group_path(@task.task_group_id)
		  flash[:notice] = "削除されました"
		end
	end

	private

	def task_params
		params.require(:task).permit(:title, :status, :task_group_id)
	end
end
