# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class PublicMessageChannel < ApplicationCable::NotificationChannel
  def subscribed
    stream_from 'public_messages'
  end
end
