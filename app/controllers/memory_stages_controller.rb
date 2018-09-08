class MemoryStagesController < ApplicationController
	before_action :ensure_correct_user, only: [:show, :create]
	before_action :ensure_correct_user_stage, only: [:update, :destroy]

	def show
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@memory_stages = @memory_group.memory_stages
		@memory_stage = @memory_group.memory_stages.new
	end

	def create
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@memory_stage = @memory_group.memory_stages.new(memory_stage_params)
		if @memory_group.memory_stages.maximum(:stage).nil?
			@memory_stage.stage = 2
		else
			@memory_stage.stage = @memory_group.memory_stages.maximum(:stage) + 1
		end
		if @memory_stage.save
			flash[:notice] = "追加されました。"
		else
			flash[:alert] = "入力エラーが発生しました。期間は1日以上に設定して下さい。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def update
		@memory_stage = MemoryStage.find(params[:id])
		if @memory_stage.update(memory_stage_params)
			flash[:notice] = "更新されました。"
		else
			flash[:alert] = "入力エラーが発生しました。期間は1日以上に設定して下さい。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def destroy
		@memory_stage = MemoryStage.find(params[:id])
		@memories = @memory_stage.memory_group.memories.where(stage: @memory_stage.stage)
		if  @memory_stage.destroy
			@memories.update_all(:stage => @memory_stage.stage-1)
		  	flash[:notice] = "削除されました。"
		else
			flash[:alert] = "エラーが発生しました。"
		end
		redirect_back(fallback_location: homes_path)
	end

	private

	def memory_stage_params
		params.require(:memory_stage).permit(:stage, :period, :memory_group_id)
	end

	def ensure_correct_user
		@memory_group = MemoryGroup.find_by(id: params[:memory_group_id])
        if current_user.id != @memory_group.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_back(fallback_location: homes_path)
        end
    end

    def ensure_correct_user_stage
		@memory_stage = MemoryStage.find_by(id: params[:id])
        if current_user.id != @memory_stage.memory_group.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_back(fallback_location: homes_path)
        end
    end
end
