class TaskDetailsController < ApplicationController
	def show
		@task = Task.find(params[:task_id])
		if @task.task_detail.time_limit.nil? || @task.task_detail.time_limit < 1
			redirect_to task_group_path(@task.task_group)
		end
	end
	def update
		@task = Task.find(params[:task_id])
		@task.task_detail.update(:time_limit => params[:update_limit])
		redirect_back(fallback_location: homes_path)
	end
end
