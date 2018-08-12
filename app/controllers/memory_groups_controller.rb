class MemoryGroupsController < ApplicationController

	def index
		@memory_groups = current_user.memory_groups
		@memory_group = MemoryGroup.new
		@memory_stage = current_user.memory_stages.new
	end

	def create
		@memory_group = MemoryGroup.new(memory_group_params)
		@memory_group.user_id = current_user.id
		if @memory_group.save
			redirect_to memory_groups_path
		else
			render 'index'
		end
	end

	def show
		@memory_group = MemoryGroup.find(params[:id])
		@memory = Memory.new
		@memory.build_problem
		@memory.build_problem_image
		@memory.build_answer
		@memory.build_answer_image
	end

	private

	def memory_group_params
		params.require(:memory_group).permit(:title, :content, :user_id)
	end
end
