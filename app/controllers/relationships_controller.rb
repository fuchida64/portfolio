class RelationshipsController < ApplicationController
  before_action :authenticate_user!

	def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    redirect_back(fallback_location: homes_path)
  end

  def destroy
    @user = Relationship.find(params[:id]).following
    current_user.unfollow!(@user)
    redirect_back(fallback_location: homes_path)
  end
end
