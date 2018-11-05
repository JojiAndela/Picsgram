class ShareController < ApplicationController
  before_action :authenticate_user!
  def users
    render json: User.all, root: false
  end
end
