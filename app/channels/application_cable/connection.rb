module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :anonymous

    def connect
      self.current_user = find_verified_user
      self.anonymous = find_anonymous
      logger.add_tags 'ActionCable', current_user&.login, anonymous
    end

    protected
    def find_verified_user
      User.find_by(id: cookies.signed[:user_id])
    end

    def find_anonymous
      if cookies.signed['anonymous_id']
        cookies.signed['anonymous_id']
      else
        logger.info 'HACKER IS HERE'
        reject_unauthorized_connection
      end
    end
  end
end
