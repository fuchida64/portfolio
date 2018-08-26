class FavoritesController < ApplicationController
    before_action :authenticate_user!

	def create
        @diary = Diary.find(params[:diary_id])
        @favorite = current_user.favorites.new(diary_id: @diary.id)
        if  @favorite.save
            redirect_to diary_path(@diary)
        else
            flash[:notice] = "エラーが発生しました。"
            redirect_to diary_path(@diary)
        end
    end

    def destroy
        @diary = Diary.find(params[:diary_id])
        @favorite = current_user.favorites.find_by(diary_id: params[:diary_id])
        if  @favorite.destroy
            redirect_to diary_path(@diary)
        else
            flash[:notice] = "エラーが発生しました。"
            redirect_to diary_path(@diary)
        end
    end
end
