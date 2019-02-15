class MessagesController < ApplicationController
  def index
  end

  def new; end

  def create
    enc_message = MessageEncryptorService.new(message_params[:text]).encrypt 
    @view_params = { key: enc_message[:key], destroy_option: message_params[:destroy_option] }
  end

  private

  def message_params
    params.require(:message).permit(:text, :destroy_option)
  end
end
