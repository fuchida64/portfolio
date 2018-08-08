class MemoriesController < ApplicationController

	def show
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@stage = params[:stage]
		if 	@stage != "all"
			@memories = @memory_group.memories.where(stage: @stage).where("execution_date <= ?", Date.current)
		else
			@memories = @memory_group.memories.where.not(stage: 0).where("execution_date <= ?", Date.current)
		end
	end

	def create
		@memory_group = MemoryGroup.find(params[:memory_group_id])
		@memory = Memory.new(memory_params)
		@memory.memory_group_id = @memory_group.id
		@memory.execution_date = Date.current
		@memory.save
		redirect_back(fallback_location: homes_path)
	end

	def correct
		@memory = Memory.find(params[:id])
		if current_user.memory_stages.exists?
			render 'index'
		else
			@memory.update(:stage => 0)
			redirect_back(fallback_location: homes_path)
		end
	end

	def wrong
		@memory = Memory.find(params[:id])
		if 	params[:stage] == "1"
			@memory.update(:execution_date => Date.tomorrow)
			redirect_back(fallback_location: homes_path)
		else
			redirect_back(fallback_location: homes_path)
		end
	end

	private

	def memory_params
		params.require(:memory).permit(
		  :stage,:execution_date,:memory_group_id,
		  problem_attributes: [:id, :problem_content, :memory_id, :_destroy],
		  problem_image_attributes: [:id, :problem_image, :memory_id, :_destroy],
		  answer_attributes: [:id, :answer_content, :memory_id, :_destroy],
		  answer_image_attributes: [:id, :answer_image, :memory_id, :_destroy]
		)
	end
end
