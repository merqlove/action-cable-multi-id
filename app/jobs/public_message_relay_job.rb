class PublicMessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'public_messages',
                                 message: MessagesController.render(partial: 'messages/message', locals: { message: message })
  end
end
