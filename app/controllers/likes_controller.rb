class LikesController < ApplicationController
before_action :authenticate_user!
  respond_to :js

  def like
    @pic = Pic.find(params[:pic_id])
    @user = current_user
    @user.like!(@pic)
  end

  def unlike
    @user = current_user
    @pic = Pic.find(params[:pic_id])
    @like = @user.likes.find_by_pic_id(params[:pic_id])
    @like.destroy
  end
end
