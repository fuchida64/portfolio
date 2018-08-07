class DiariesController < ApplicationController

	def index
		@diaries = Diary.all
		@diary_images = DiaryImage.all
	end

	def new
		@diary = Diary.new
		4.times{@diary.diary_images.build}
	end

	def create
		@diary = Diary.new(diary_params)
		@diary.user_id = current_user.id
		@diary.save
		redirect_to diaries_path
	end

	private

	def diary_params
		params.require(:diary).permit(
			:title, :content, :user_id, :inform_status,
			diary_images_attributes: [:id, :diary_id, :diary_image, :_destroy]
			)
	end
end
