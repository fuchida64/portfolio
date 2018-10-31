class MemoriesController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user_group, only: [:step_index, :show, :create]
	before_action :ensure_correct_user, only: [:correct, :wrong, :update, :destroy]

	def index
		@memory_group = MemoryGroup.find(params[:group])
		if user_signed_in?
			if current_user.id != @memory_group.user_id
				redirect_back(fallback_location: homes_path)
				flash[:alert] = "アクセス権限がありません。"
			end
			@memories = @memory_group.memories

			@maxNum = @memories.where(stage: 1).length
			@maxStage = 1
			@memory_group.memory_stages.each do |s|
				if @memories.where(stage: s.stage).length > @maxNum
					@maxNum = @memories.where(stage: s.stage).length
					@maxStage = s.stage
				end
			end
		else
			redirect_back(fallback_location: homes_path)
			flash[:alert] = "アクセス権限がありません。"
		end
	end

	def step_index
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@stage = params[:stage]
		if 	@stage != "all"
			@memories = @memory_group.memories.where(stage: @stage).order(execution_date: :asc)
		else
			@memories = @memory_group.memories.order(execution_date: :asc)
		end
	end

	def all_show
		@memory_groups = current_user.memory_groups
		@memories = []
		@memory_groups.each do |mg|
			if mg.loop == 1
				if mg.memories.where("execution_date <= ?", Date.current).present?
					mg.memories.where("execution_date <= ?", Date.current).each do |m|
						@memories << m.id
					end
				end
			else
				if mg.memories.where.not(stage: 0).where("execution_date <= ?", Date.current).present?
					mg.memories.where.not(stage: 0).where("execution_date <= ?", Date.current).each do |m|
						@memories << m.id
					end
				end
			end
		end
		if @memories.empty?
			flash[:notice] = "clear !"
			redirect_to memory_groups_path(@memory_group)
		end
		@memory_id = @memories.shuffle.first
		@memory = Memory.find(@memory_id)
		@memory_group = @memory.memory_group
	end

	def show
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@stage = params[:stage]
		if 	@stage != "all"
			@memories = @memory_group.memories.where(stage: @stage).where("execution_date <= ?", Date.current)
		else
			if @memory_group.loop == 1
				@memories = @memory_group.memories.where("execution_date <= ?", Date.current)
			else
				@memories = @memory_group.memories.where.not(stage: 0).where("execution_date <= ?", Date.current)
			end
		end
		if @memories.empty?
			flash[:notice] = "clear !"
			redirect_to memory_group_path(@memory_group)
		end
		if @memories.where("perform_date < ?", Date.current).present?
			@memory = @memories.where("perform_date < ?", Date.current).shuffle.first
		else
			@memory = @memories.shuffle.first
		end
	end

	def create
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@memory = Memory.new(memory_params)
		@memory.memory_group_id = @memory_group.id
		@memory.execution_date = Date.current
		@memory.perform_date = Date.yesterday
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
		if @memory_stages.present?
			if @memory.stage < @memory_stages.maximum(:stage) && @memory.stage > 0
				next_stage = @memory.stage + 1
				@memory_stage = @memory_stages.find_by(stage: next_stage)
				if @memory.perform_date == Date.current
					@memory.update(:execution_date => Date.tomorrow)
				else
					@memory.update(:stage => next_stage, :correct_num => correct_num, :execution_date => Date.current.next_day(@memory_stage.period))
				end
			else
				if @memory.perform_date == Date.current
					@memory.update(:execution_date => Date.tomorrow)
				else
					@memory.update(:stage => 0, :correct_num => correct_num, :execution_date => Date.current.next_day(@memory.memory_group.period))
				end
			end
		else
			if @memory.perform_date == Date.current
				@memory.update(:execution_date => Date.tomorrow)
			else
				@memory.update(:stage => 0, :correct_num => correct_num, :execution_date => Date.current.next_day(@memory.memory_group.period))
			end
		end
		redirect_back(fallback_location: homes_path)
	end

	def wrong
		@memory = Memory.find(params[:id])
		wrong_num = @memory.wrong_num + 1
		if @memory.memory_group.untie == 0
			@memory.update(:stage => 1, :wrong_num => wrong_num, :execution_date => Date.tomorrow)
		end
		if @memory.perform_date < Date.current
			@memory.update(:stage => 1, :wrong_num => wrong_num, :perform_date => Date.current)
		end
		redirect_back(fallback_location: homes_path)
	end

	def update
		@memory = Memory.find(params[:id])
		if @memory.update(memory_params)
			flash[:notice] = "更新されました。"
		else
			flash[:alert] = "入力エラーが発生しました。problemフォームには、最低1項目の入力が必要です。"
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
		  :problem_content, :problem_image, :answer_content, :answer_image, :stage, :execution_date, :perform_date, :correct_num, :wrong_num, :memory_group_id,
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
