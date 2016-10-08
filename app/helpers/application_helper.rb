module ApplicationHelper
  def logged_in?
    Rails.logger.info @current_user
    @current_user.present?
  end
end
