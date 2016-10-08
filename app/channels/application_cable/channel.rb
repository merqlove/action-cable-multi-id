module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      return reject && false unless logged_in?
      true
    end

    private

    def logged_in?
      self.current_user.present?
    end
  end
end
