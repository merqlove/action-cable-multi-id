module Authentication
  extend ActiveSupport::Concern

  included do
    # before_action :ensure_authenticated_user
    before_action :set_anonymous_id
  end

  private

  def logged_in?
    @current_user.present?
  end

  def safe_ensure_authenticated_user
    authenticate_user(cookies.signed[:user_id])
  end

  def ensure_authenticated_user
    authenticate_user(cookies.signed[:user_id]) || redirect_to(new_session_url)
  end

  def set_anonymous_id
    cookies.signed[:anonymous_id] ||= UUID.generate
  end

  def authenticate_user(user_id)
    if authenticated_user = User.find_by(id: user_id)
      ActionCable.server.disconnect(current_user: nil, anonymous: cookies.signed[:anonymous_id])
      cookies.signed[:user_id] ||= user_id
      @current_user = authenticated_user
    end
  end

  def unauthenticate_user
    ActionCable.server.disconnect(current_user: @current_user, anonymous: cookies.signed[:anonymous_id])
    @current_user = nil
    cookies.delete(:user_id)
  end
end
