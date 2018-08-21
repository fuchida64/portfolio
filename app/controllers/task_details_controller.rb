class TaskDetailsController < ApplicationController
	def show
		@task = Task.find(params[:task_id])
	end
	def update
		@task = Task.find(params[:task_id])
		@task.task_detail.update(:time_limit => params[:update_limit])
		redirect_back(fallback_location: homes_path)
	end
end
