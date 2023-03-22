module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # include ActionController::Cookies
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      unless env['warden'].user == nil
        if verified_user = User.find_by(id: env['warden'].user.id)
          verified_user
        else
          reject_unauthorized_connection
        end
      end
    end
  end
end