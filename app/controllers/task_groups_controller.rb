class TaskGroupsController < ApplicationController

	def index
		@task_groups = current_user.task_groups
		@task_group = TaskGroup.new
		@tasks = Task.all
	end

	def create
		@task_group = TaskGroup.new(task_group_params)
		@task_group.user_id = current_user.id
		if @task_group.save
			redirect_to task_groups_path
		else
			render 'index'
		end
	end

	def show
		@task_group = TaskGroup.find(params[:id])
		@task_groups = TaskGroup.where.not(id: @task_group.id)
		@tasks = @task_group.tasks
		@task = Task.new
		@task.build_task_detail
	end

	def update
		@task_group = TaskGroup.find(params[:id])
		if @task_group.update(task_group_params)
			redirect_to task_groups_path
		else
			render 'index'
		end
	end

	def destroy
		@task_group = TaskGroup.find(params[:id])
		if  @task_group.destroy
		  	flash[:notice] = "削除されました"
		else
			flash[:alert] = "エラーが発生しました"
		end
		redirect_to task_groups_path
	end

	def destroy_all
		@task_group = TaskGroup.find(params[:id])
		if  params[:status] == '3'
			@tasks = @task_group.tasks.where(status: 3)
			@tasks.destroy_all
		  	flash[:notice] = "削除されました"
		else
			flash[:notice] = "エラーが発生しました"
		end
		redirect_back(fallback_location: homes_path)
	end

	private

	def task_group_params
		params.require(:task_group).permit(:title, :content, :user_id)
	end
end
