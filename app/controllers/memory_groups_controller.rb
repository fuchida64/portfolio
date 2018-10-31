class MemoryGroupsController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, except: [:index, :create, :position_update]

	def index
		@memory_groups = current_user.memory_groups.order(position_id: :asc)
		@all_memories = 0
		@memory_groups.each do |mg|
			if mg.loop == 1
				@all_memories += mg.memories.where("execution_date <= ?", Date.current).size
			else
				@all_memories += mg.memories.where.not(stage: 0).where("execution_date <= ?", Date.current).size
			end
		end
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
			flash[:notice] = "作成されました。"
		else
			flash[:alert] = "入力エラーが発生しました。リスト名は1~20文字以内です。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def show
		@memory_group = MemoryGroup.find(params[:id])
		if @memory_group.loop == 1
			@today_memories = @memory_group.memories.where("execution_date <= ?", Date.current)
		else
			@today_memories = @memory_group.memories.where.not(stage: 0).where("execution_date <= ?", Date.current)
		end
		@memory = Memory.new
		@maxNum = @today_memories.where(stage: 1).length
		@maxStage = 1
		@memory_group.memory_stages.each do |s|
			if @today_memories.where(stage: s.stage).length > @maxNum
				@maxNum = @today_memories.where(stage: s.stage).length
				@maxStage = s.stage
			end
		end
	end

	def update
		@memory_group = MemoryGroup.find(params[:id])
		if @memory_group.update(memory_group_params)
			flash[:notice] = "更新されました。"
		else
			if params[:stage] == 'loop'
				flash[:alert] = "入力エラーが発生しました。期間は1日以上に設定して下さい。"
			else
				flash[:alert] = "入力エラーが発生しました。リスト名は1~20文字以内です。"
			end
		end
		redirect_back(fallback_location: homes_path)
	end

	def destroy
		@memory_group = MemoryGroup.find(params[:id])
		if  @memory_group.destroy
		  	flash[:notice] = "削除されました。"
		else
			flash[:alert] = "エラーが発生しました。"
		end
		redirect_to memory_groups_path
	end

	def position_update
		result = params[:position]
		i = 1
		result.each do |id|
			if id != "none"
				@memory_group = MemoryGroup.find(id)
				@memory_group.update(:position_id => i)
				i += 1
			end
		end
	end

	private

	def memory_group_params
		params.require(:memory_group).permit(
			:title, :content, :loop, :period, :untie, :user_id,
			memory_stages_attributes: [:id, :stage, :period, :memory_group_id, :position_id, :_destroy]
		)
	end

	def ensure_correct_user
		@memory_group = MemoryGroup.find_by(id: params[:id])
        if current_user.id != @memory_group.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_to homes_path
        end
    end
end
