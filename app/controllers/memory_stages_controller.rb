class MemoryStagesController < ApplicationController

	def create
		@memory_stage = current_user.memory_stages.new(memory_stage_params)
		@memory_stage.stage = (current_user.memory_stages.length + 1)
		@memory_stage.save
		redirect_back(fallback_location: homes_path)
	end

	private

	def memory_stage_params
		params.require(:memory_stage).permit(:stage,:period,:user_id)
	end
end
