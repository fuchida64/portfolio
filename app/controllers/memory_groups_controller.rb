class MemoryGroupsController < ApplicationController

	def index
		@memory_groups = current_user.memory_groups
		@memory_group = MemoryGroup.new
		@default_stage = current_user.default_stages.new
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
			redirect_back(fallback_location: homes_path)
		else
			render 'index'
		end
	end

	def show
		@memory_group = MemoryGroup.find(params[:id])
		@memory_stage = MemoryStage.new
		@memory = Memory.new
		@memory.build_problem
		@memory.build_problem_image
		@memory.build_answer
		@memory.build_answer_image
	end

	private

	def memory_group_params
		params.require(:memory_group).permit(
			:title, :content, :user_id,
			memory_stages_attributes: [ :id, :stage, :period, :memory_group_id, :_destroy]
		)
	end
end
