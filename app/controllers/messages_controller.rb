class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def create
    @message = @chatroom.messages.new(message_params)
    @message.user = current_user
    @message.save
    (@chatroom.users.uniq - [current_user]).each do |user|
      Notification.create(recipient: user, actor: current_user, action: "sent", notifiable: @message)
    end
    MessageRelayJob.perform_later(@message)
    redirect_back(fallback_location: root_path)
  end

  private

    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end

    def message_params
      params.require(:message).permit(:body)
    end
end
