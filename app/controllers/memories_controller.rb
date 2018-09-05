class MemoriesController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, only: [:create]

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
		if params[:memory][:problem_attributes][:problem_content].blank? && (params[:memory][:problem_image_attributes][:problem_image] == "{}")
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

	def edit
		@memory = Memory.find(params[:id])
	end

	def update
		@memory = Memory.find(params[:id])
		@memory.update(memory_params)
		redirect_to memory_group_path(@memory.memory_group)
	end

	private

	def memory_params
		params.require(:memory).permit(
		  :stage, :execution_date, :correct_num, :wrong_num, :memory_group_id,
		  problem_attributes: [:id, :problem_content, :memory_id, :_destroy],
		  problem_image_attributes: [:id, :problem_image, :memory_id, :_destroy],
		  answer_attributes: [:id, :answer_content, :memory_id, :_destroy],
		  answer_image_attributes: [:id, :answer_image, :memory_id, :_destroy]
		)
	end

	def ensure_correct_user
		@memory_group = MemoryGroup.find_by(id: params[:memory_group_id])
        if current_user.id != @memory_group.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_back(fallback_location: homes_path)
        end
    end

end
