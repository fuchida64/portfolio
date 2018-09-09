class DiariesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :search]
	before_action :ensure_correct_user, only: [:edit, :update, :destroy]

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

	def edit
		@diary = Diary.find(params[:id])
	end

	def update
		@diary = Diary.find(params[:id])
		if @diary.update(diary_params)
			flash[:notice] = "更新されました。"
			redirect_to diary_path(@diary)
		else
			render 'edit'
		end
	end

	def destroy
		@diary = Diary.find(params[:id])
		if  @diary.destroy
		  	flash[:notice] = "削除されました。"
		  	redirect_to diaries_path
		else
			flash[:alert] = "エラーが発生しました。"
			redirect_back(fallback_location: homes_path)
		end
	end

	private

	def diary_params
		params.require(:diary).permit(
			:title, :content, :diary_date, :user_id, :inform_status,
			diary_images_attributes: [:id, :diary_id, :diary_image, :_destroy]
			)
	end

	def ensure_correct_user
		@diary = Diary.find_by(id: params[:id])
        if current_user.id != @diary.user_id
           flash[:alert] = "アクセス権限がありません。"
           redirect_back(fallback_location: homes_path)
        end
    end
end
