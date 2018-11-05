class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chatroom.id}", {
      username: message.user.username,
      body: message.body, #MessagesController.render(partial: 'messages/message',locals:{message: message}),#message.body,
      chatroom_id: message.chatroom.id,
      id: message.id
    }


  end
end
