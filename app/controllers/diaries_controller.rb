class DiariesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :search]

	def index
		@diaries = Diary.all.where(inform_status: '公開').order(id: :desc).page(params[:page]).per(9)
	end

	def search
		@diaries = Diary.search(params[:search]).order(id: :desc).page(params[:page]).per(9)
	end

	def new
		@diary = Diary.new
		4.times{@diary.diary_images.build}
	end

	def create
		@diary = Diary.new(diary_params)
		@diary.user_id = current_user.id
		if 	@diary.save
			flash[:notice] = "作成されました。"
			redirect_to diaries_path
		else
			render 'new'
		end
	end

	def show
		@diary = Diary.find(params[:id])
		@user = @diary.user
		if (@diary.inform_status == '非公開' && @user == current_user) || @diary.inform_status == '公開'
			@diary_comment = DiaryComment.new
		else
			redirect_to diaries_path
		end
	end

	private

	def diary_params
		params.require(:diary).permit(
			:title, :content, :diary_date, :user_id, :inform_status,
			diary_images_attributes: [:id, :diary_id, :diary_image, :_destroy]
			)
	end
end
