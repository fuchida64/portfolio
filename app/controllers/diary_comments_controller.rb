class DiaryCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
	    @diary = Diary.find(params[:diary_id])
	    @diary_comment = current_user.diary_comments.new(diary_comment_params)
	    @diary_comment.diary_id = @diary.id
	    if @diary_comment.save
	    else
	    	flash[:alert] = "入力エラーが発生しました。"
	    end
	    redirect_back(fallback_location: homes_path)
	end

	private

	def diary_comment_params
		params.require(:diary_comment).permit(:user_id,:diary_id,:comment)
	end
end
