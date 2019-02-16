class MessagesController < ApplicationController
  require 'net/http'

  def index
  end

  def new; end

  def create
    enc_message = MessageEncryptorService.new(message_params[:text]).encrypt
    @message_info = {
      encryption_key: enc_message[:key],
      destroy_option: message_params[:destroy_option],
      urlsafe: SecureRandom.urlsafe_base64
    }

    message = { text_message: enc_message[:encrypted_message] }.merge(@message_info)
    uri = URI.parse('http://localhost:4567/message')
    response = Net::HTTP.post_form(uri, message)
  end

  private

  def message_params
    params.require(:message).permit(:text, :destroy_option)
  end
end
