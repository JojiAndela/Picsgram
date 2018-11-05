class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, only: %i[show update destroy]

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def show
    if @friend_request.user == current_user
      redirect_to @friend_request.friend
    else
      redirect_to @friend_request.user
    end
  end

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    unless @friend_request.save
        flash[:danger] = "Friend request could not be sent."
    end
    Notification.create(recipient: friend, actor: current_user, action: "sent you a ", notifiable: @friend_request)
    redirect_back fallback_location: root_path
  end

  def update
    # friend = @friend_request.user
    # Notification.create(recipient: friend, actor: current_user, action: "accepted your", notifiable: @friend_request)
    @friend_request.accept
    redirect_back fallback_location: root_path
  end

  def destroy
    @friend_request.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
