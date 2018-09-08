class MemoriesController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user_group, only: [:step_index, :create]
	before_action :ensure_correct_user, only: [:correct, :wrong, :update, :destroy]

	def index
		@memory_group = MemoryGroup.find(params[:group])
		if user_signed_in?
			if current_user.id != @memory_group.user_id
				redirect_back(fallback_location: homes_path)
				flash[:alert] = "アクセス権限がありません。"
			end
			@memories = @memory_group.memories
		else
			redirect_back(fallback_location: homes_path)
			flash[:alert] = "アクセス権限がありません。"
		end
	end

	def step_index
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@stage = params[:stage]
		if 	@stage != "all"
			@memories = @memory_group.memories.where(stage: @stage)
		else
			@memories = @memory_group.memories
		end
	end

	def show
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@stage = params[:stage]
		if 	@stage != "all"
			@memories = @memory_group.memories.where(stage: @stage).where("execution_date <= ?", Date.current)
		else
			@memories = @memory_group.memories.where.not(stage: 0).where("execution_date <= ?", Date.current)
		end
		if @memories.empty?
			redirect_to memory_group_path(@memory_group)
		end
		@memory = @memories.shuffle.first
	end

	def create
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@memory = Memory.new(memory_params)
		@memory.memory_group_id = @memory_group.id
		@memory.execution_date = Date.current
		if params[:memory][:problem_content].blank? && (params[:memory][:problem_image] == "{}")
			flash[:alert] = "入力エラーが発生しました。problemフォームには、最低1項目の入力が必要です。"
		else
			@memory.save
			flash[:notice] = "作成されました。"
		end
		redirect_back(fallback_location: homes_path)
	end
	def correct
		@memory = Memory.find(params[:id])
		@memory_stages = @memory.memory_group.memory_stages
		correct_num = @memory.correct_num + 1
		if @memory_stages.present? && (params[:stage] == "all")
			if @memory.stage < @memory_stages.maximum(:stage)
				next_stage = (@memory.stage + 1)
				@memory_stage = @memory_stages.find_by(stage: next_stage)
				@memory.update(:stage => next_stage, :correct_num => correct_num, :execution_date => Date.current.next_day(@memory_stage.period))
			else
				@memory.update(:stage => 0, :correct_num => correct_num)
			end
		elsif @memory_stages.present? && (@memory_stages.maximum(:stage) != params[:stage].to_i)
			next_stage = (params[:stage].to_i + 1)
			@memory_stage = @memory_stages.find_by(stage: next_stage)
			@memory.update(:stage => next_stage, :correct_num => correct_num, :execution_date => Date.current.next_day(@memory_stage.period))
		else
			@memory.update(:stage => 0, :correct_num => correct_num)
		end
		redirect_back(fallback_location: homes_path)
	end

	def wrong
		@memory = Memory.find(params[:id])
		wrong_num = @memory.wrong_num + 1
		@memory.update(:stage => 1, :wrong_num => wrong_num, :execution_date => Date.tomorrow)
		redirect_back(fallback_location: homes_path)
	end

	def update
		@memory = Memory.find(params[:id])
		if params[:memory][:problem_content].blank? && (params[:memory][:problem_image] == "{}")
			flash[:alert] = "入力エラーが発生しました。problemフォームには、最低1項目の入力が必要です。"
		else
			@memory.update(memory_params)
			flash[:notice] = "更新されました。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def destroy
		@memory = Memory.find(params[:id])
		if  @memory.destroy
		  	flash[:notice] = "削除されました。"
		else
			flash[:alert] = "エラーが発生しました。"
		end
		redirect_back(fallback_location: homes_path)
	end

	private

	def memory_params
		params.require(:memory).permit(
		  :problem_content, :problem_image, :answer_content, :answer_image, :stage, :execution_date, :correct_num, :wrong_num, :memory_group_id,
		)
	end

	def ensure_correct_user_group
		@memory_group = MemoryGroup.find_by(id: params[:memory_group_id])
        if current_user.id != @memory_group.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_back(fallback_location: homes_path)
        end
    end

    def ensure_correct_user
		@memory = Memory.find_by(id: params[:id])
        if current_user.id != @memory.memory_group.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_back(fallback_location: homes_path)
        end
    end

end
