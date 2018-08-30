class MemoryStagesController < ApplicationController

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
			flash[:notice] = "追加されました"
		else
			flash[:alert] = "入力エラーが発生しました。期間は1日以上に設定して下さい。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def update
		@memory_stage = MemoryStage.find(params[:id])
		if @memory_stage.update(memory_stage_params)
			flash[:notice] = "更新されました"
		else
			flash[:alert] = "入力エラーが発生しました。期間は1日以上に設定して下さい。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def destroy
		@memory_stage = MemoryStage.find(params[:id])
		if  @memory_stage.destroy
		  	flash[:notice] = "削除されました"
		else
			flash[:alert] = "エラーが発生しました"
		end
		redirect_back(fallback_location: homes_path)
	end

	private

	def memory_stage_params
		params.require(:memory_stage).permit(:stage, :period, :memory_group_id)
	end
end
