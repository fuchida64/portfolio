class TaskDetailsController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, only: [:show, :update]

	def show
		@task = Task.find(params[:task_id])
		if @task.task_detail.time_limit.nil? || @task.task_detail.time_limit < 1
			flash[:notice] = "タイムアップです。"
			redirect_to task_group_path(@task.task_group)
		end
	end

	def update
		@task = Task.find(params[:task_id])
		if @task.task_detail.update(:time_limit => params[:update_limit])
			redirect_back(fallback_location: homes_path)
		else
			flash[:alert] = "エラーが発生しました。"
			redirect_back(fallback_location: homes_path)
		end
	end

	private

	def ensure_correct_user
		@task = Task.find_by(id: params[:task_id])
        if current_user.id != @task.task_group.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_back(fallback_location: homes_path)
        end
    end
end
