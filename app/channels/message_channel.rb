# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessageChannel < ApplicationCable::Channel
  def subscribed
    return unless super
    stream_from 'messages'
  end
end
