# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NotificationChannel < NotificationCable::Channel
  def subscribed
    stream_from 'notifications'
  end
end
