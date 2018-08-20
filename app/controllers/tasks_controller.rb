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
		if  @task.status < 3
			@task.update(:status => @task.status + 1)
			redirect_back(fallback_location: homes_path)
		else
			@task.update(:status => @task.status - 1)
			redirect_back(fallback_location: homes_path)
		end
	end

	def destroy
		@task = Task.find(params[:id])
		if @task.destroy
		  redirect_to task_group_path(@task.task_group_id)
		end
	end

	def position_update
		result1 = params[:result1]
		position1 = result1.split(',')
		position1.each.with_index(1) do |result, i|
			@task = Task.find(result)
			@task.update(:status => 1, :position => i)
		end

		result2 = params[:result2]
		position2 = result2.split(',')
		position2.each.with_index(1) do |result, i|
			@task = Task.find(result)
			@task.update(:status => 2, :position => i)
		end

		result3 = params[:result3]
		position3 = result3.split(',')
		position3.each.with_index(1) do |result, i|
			@task = Task.find(result)
			@task.update(:status => 3, :position => i)
		end
		redirect_back(fallback_location: homes_path)
	end

	private

	def task_params
		params.require(:task).permit(
		  :title, :status, :position, :task_group_id,
		  task_detail_attributes: [:id, :deadline, :time_required, :time_limit, :task_id, :_destroy]
		)
	end
end
