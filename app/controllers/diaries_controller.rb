class DiariesController < ApplicationController

	def index
		@diaries = Diary.all
	end

	def new
		@diary = Diary.new
	end

	def create
		@diary = Diary.new(diary_params)
		@diary.user_id = current_user.id
		@diary.save
		redirect_to diaries_path
	end

	private

	def diary_params
		params.require(:diary).permit(:title, :contents, :user_id, :public)
	end
end
