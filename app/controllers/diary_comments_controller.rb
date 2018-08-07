class DiaryCommentsController < ApplicationController

	def create
	    @diary = Diary.find(params[:diary_id])
	    @diary_comment = current_user.diary_comments.new(diary_comment_params)
	    @diary_comment.diary_id = @diary.id
	    @diary_comment.save
	    redirect_to diary_path(@diary.id)
	end

	private

	def diary_comment_params
	  params.require(:diary_comment).permit(:user_id,:diary_id,:comment)
	end
end
