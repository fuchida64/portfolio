class TaskGroupsController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, only: [:show, :update, :destroy, :destroy_all]

	def index
		@task_groups = current_user.task_groups.order(position_id: :asc)
		@task_group = TaskGroup.new
		@tasks = Task.all
	end

	def create
		@task_group = TaskGroup.new(task_group_params)
		@task_group.user_id = current_user.id
		if @task_group.save
			flash[:notice] = "作成されました。"
		else
			flash[:alert] = "入力エラーが発生しました。リスト名は1~20文字以内です。"
		end
		redirect_back(fallback_location: homes_path)
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
			flash[:notice] = "更新されました。"
		else
			flash[:alert] = "入力エラーが発生しました。リスト名は1~20文字以内です。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def destroy
		@task_group = TaskGroup.find(params[:id])
		if  @task_group.destroy
		  	flash[:notice] = "削除されました。"
		else
			flash[:alert] = "エラーが発生しました。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def position_update
		result = params[:position]
		result.each.with_index(1) do |id, i|
			@task_group = TaskGroup.find(id)
			@task_group.update(:position_id => i)
		end
	end

	def destroy_all
		@task_group = TaskGroup.find(params[:id])
		if  params[:status] == '3'
			@tasks = @task_group.tasks.where(status: 3)
			@tasks.destroy_all
		  	flash[:notice] = "削除されました。"
		else
			flash[:notice] = "エラーが発生しました。"
		end
		redirect_back(fallback_location: homes_path)
	end

	private

	def task_group_params
		params.require(:task_group).permit(:title, :content, :position_id, :user_id)
	end

	def ensure_correct_user
		@task_group = TaskGroup.find_by(id: params[:id])
        if current_user.id != @task_group.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_back(fallback_location: homes_path)
        end
    end
end
