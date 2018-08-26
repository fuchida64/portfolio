class DiaryCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
	    @diary = Diary.find(params[:diary_id])
	    @diary_comment = current_user.diary_comments.new(diary_comment_params)
	    @diary_comment.diary_id = @diary.id
	    if @diary_comment.save
	    	redirect_to diary_path(@diary)
	    else
	    	flash[:alert] = "エラーが発生しました"
	    	redirect_to diary_path(@diary)
	    end
	end

	private

	def diary_comment_params
	  params.require(:diary_comment).permit(:user_id,:diary_id,:comment)
	end
end
