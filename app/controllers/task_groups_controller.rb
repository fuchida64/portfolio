class TaskGroupsController < ApplicationController

	def index
		@task_groups = current_user.task_groups
		@task_group_new = TaskGroup.new
	end

	def create
		@task_group_new = TaskGroup.new(task_group_params)
		@task_group_new.user_id = current_user.id
		if @task_group_new.save
			redirect_to task_groups_path
		else
			render 'index'
		end
	end

	def show
		@task_group = TaskGroup.find(params[:id])
		@tasks = @task_group.tasks
		@task_new = Task.new
	end

	def update
		@task_group = TaskGroup.find(params[:id])
		if @task_group.update(task_group_params)
			redirect_to task_groups_path
		else
			render 'index'
		end
	end

	private

	def task_group_params
		params.require(:task_group).permit(:title, :contents, :user_id)
	end
end
