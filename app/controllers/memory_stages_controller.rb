class MemoryStagesController < ApplicationController

	def create
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@memory_stage = MemoryStage.new(memory_stage_params)
		@memory_stage.memory_group_id = @memory_group.id
		@memory_stage.stage = @memory_group.memory_stages.maximum(:stage) + 1
		@memory_stage.save
		redirect_back(fallback_location: homes_path)
	end

	private

	def memory_stage_params
		params.require(:memory_stage).permit(:stage, :period)
	end
end
