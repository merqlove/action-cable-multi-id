module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      logger.info 'ApplicationCable'
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user
    end

    protected

    def find_verified_user
      if cookies['user_uuid']
        cookies['user_uuid']
      else
        reject_unauthorized_connection
      end
    end
  end
end
