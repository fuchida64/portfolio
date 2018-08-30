class MemoryGroupsController < ApplicationController
	before_action :ensure_correct_user, except: [:index, :create]

	def index
		@memory_groups = current_user.memory_groups
		@memory_group = MemoryGroup.new
	end

	def create
		@memory_group = MemoryGroup.new(memory_group_params)
		@memory_group.user_id = current_user.id
		if @memory_group.save
			current_user.default_stages.each do |d|
				@memory_stage = MemoryStage.new
				@memory_stage.memory_group_id = @memory_group.id
				@memory_stage.stage = d.stage
				@memory_stage.period = d.period
				@memory_stage.save
			end
			flash[:notice] = "作成されました"
		else
			flash[:alert] = "入力エラーが発生しました。リスト名は1~20文字以内です。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def show
		@memory_group = MemoryGroup.find(params[:id])
		@today_memories = @memory_group.memories.where("execution_date <= ?", Date.current)
		@memory = Memory.new
		@memory.build_problem
		@memory.build_problem_image
		@memory.build_answer
		@memory.build_answer_image
	end

	def update
		@memory_group = MemoryGroup.find(params[:id])
		if @memory_group.update(memory_group_params)
			flash[:notice] = "更新されました"
		else
			flash[:alert] = "入力エラーが発生しました。リスト名は1~20文字以内です。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def destroy
		@memory_group = MemoryGroup.find(params[:id])
		if  @memory_group.destroy
		  	flash[:notice] = "削除されました"
		else
			flash[:alert] = "エラーが発生しました"
		end
		redirect_to memory_groups_path
	end

	private

	def memory_group_params
		params.require(:memory_group).permit(
			:title, :content, :user_id,
			memory_stages_attributes: [ :id, :stage, :period, :memory_group_id, :_destroy]
		)
	end

	def ensure_correct_user
		@memory_group = MemoryGroup.find_by(id: params[:id])
        if current_user.id != @memory_group.user_id
           flash[:alert] = "権限がありません"
           redirect_to homes_path
        end
    end
end
