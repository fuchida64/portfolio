class TasksController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, only: [:update, :check, :destroy]

	def create
		@task = Task.new(task_params)
		@task.task_group_id = params[:group_id]
		if @task.save
			flash[:notice] = "作成されました。"
		else
			flash[:alert] = "入力エラーが発生しました。リスト名は1~20文字以内です。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def update
		@task = Task.find(params[:id])

		if @task.update(task_params)
			flash[:notice] = "更新されました。"
		else
			flash[:alert] = "入力エラーが発生しました。リスト名は1~20文字以内です。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def check
		@task = Task.find(params[:id])
		if  @task.status < 3
			@task.update(:status => @task.status + 1)
		else
			@task.update(:status => @task.status - 1)
		end
		redirect_back(fallback_location: homes_path)
	end

	def destroy
		@task = Task.find(params[:id])
		if  @task.destroy
		  	flash[:notice] = "削除されました。"
		else
			flash[:alert] = "エラーが発生しました。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def position_update
		result1 = params[:result1]
		position1 = result1.split(',')
		position1.each.with_index(1) do |result, i|
			@task = Task.find(result)
			@task.update(:status => 1, :position_id => i)
		end
		result2 = params[:result2]
		position2 = result2.split(',')
		position2.each.with_index(1) do |result, i|
			@task = Task.find(result)
			@task.update(:status => 2, :position_id => i)
		end
		result3 = params[:result3]
		position3 = result3.split(',')
		position3.each.with_index(1) do |result, i|
			@task = Task.find(result)
			@task.update(:status => 3, :position_id => i)
		end
		redirect_back(fallback_location: homes_path)
	end

	def stage_position_update
		result = params[:position]
		result.each.with_index(1) do |id, i|
			@task = Task.find(id)
			@task.update(:position_id => i)
		end
	end

	private

	def task_params
		params.require(:task).permit(
		  :title, :status, :position_id, :task_group_id,
		  task_detail_attributes: [:id, :deadline, :time_required, :time_limit, :task_id, :_destroy]
		)
	end

	def ensure_correct_user
		@task = Task.find_by(id: params[:id])
        if current_user.id != @task.task_group.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_back(fallback_location: homes_path)
        end
    end
end
