class DefaultStagesController < ApplicationController

	def create
		@default_stage = current_user.default_stages.new(default_stage_params)
		@default_stage.stage = current_user.default_stages.maximum(:stage) + 1
		@default_stage.save
		redirect_back(fallback_location: homes_path)
	end

	private

	def default_stage_params
		params.require(:default_stage).permit(:stage,:period,:user_id)
	end
end
