class DefaultStagesController < ApplicationController
	before_action :ensure_correct_user, only: [:update, :destroy]

	def index
		@default_stage = current_user.default_stages.new
	end

	def create
		@default_stage = current_user.default_stages.new(default_stage_params)
		if current_user.default_stages.maximum(:stage).nil?
			@default_stage.stage = 2
		else
			@default_stage.stage = current_user.default_stages.maximum(:stage) + 1
		end
		if @default_stage.save
			flash[:notice] = "追加されました"
		else
			flash[:alert] = "入力エラーが発生しました。期間は1日以上に設定して下さい。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def update
		@default_stage = DefaultStage.find(params[:id])
		if @default_stage.update(default_stage_params)
			flash[:notice] = "更新されました"
		else
			flash[:alert] = "入力エラーが発生しました。期間は1日以上に設定して下さい。"
		end
		redirect_back(fallback_location: homes_path)
	end

	def destroy
		@default_stage = DefaultStage.find(params[:id])
		if  @default_stage.destroy
		  	flash[:notice] = "削除されました"
		else
			flash[:alert] = "エラーが発生しました"
		end
		redirect_back(fallback_location: homes_path)
	end

	private

	def default_stage_params
		params.require(:default_stage).permit(:stage, :period, :user_id)
	end

	def ensure_correct_user
		@default_stage = DefaultStage.find_by(id: params[:id])
        if current_user.id != @default_stage.user_id
           flash[:alert] = "権限がありません"
           redirect_to homes_path
        end
    end
end
