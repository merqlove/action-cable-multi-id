class WelcomeController < ApplicationController
  before_action :ensure_authenticated_user
  def index
  end
end
