class DiaryImagesController < ApplicationController
	private

	def diary_image_params
		params.require(:diary_image).permit(:diary_id, :diary_image)
	end
end
