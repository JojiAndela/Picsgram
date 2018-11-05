class ProfileController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find_by(username: params[:username])


    @pics = Pic.all.order('created_at DESC').where(user_id: @user.id)

  end

  def followers
    @user  = User.find_by(username: params[:username])

    @followers = @user.followers
  end
  def following
    @user  = User.find_by(username: params[:username])
    @followings = @user.following

  end
end
