class MessagesController < ApplicationController
  before_action :set_message, only: [:show]
  before_action :safe_ensure_authenticated_user, only: [:index, :create]

  # GET /messages
  # GET /messages.json
  def index
    @messages = if logged_in?
      Message.all
    else
      Message.shared
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  def create
    @message = Message.create! content: message_params[:content],
                               state: message_params[:state],
                               user: @current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.fetch(:message, {})
    end
end
