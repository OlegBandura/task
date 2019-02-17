class MessagesController < ApplicationController
  require 'net/http'

  def index; end

  def show
    uri = URI('http://localhost:4567')
    res = Net::HTTP.get(uri + '/message/' + params[:id])
    @res = JSON.parse(res) if res.present?
  end

  def read
    if show['encryption_key'] == key_params[:key]
      @decr_message = MessageEncryptorService.new(show['text_message']).decrypt(key_params[:key])
    end
  end

  def new; end

  def create
    enc_message = MessageEncryptorService.new(message_params[:text]).encrypt
    @message_info = {
      encryption_key: enc_message[:key],
      destroy_option: message_params[:destroy_option],
      count_times: message_params[:count_times],
      urlsafe: SecureRandom.urlsafe_base64
    }

    message = { text_message: enc_message[:encrypted_message] }.merge(@message_info)
    uri = URI.parse('http://localhost:4567/message')
    response = Net::HTTP.post_form(uri, message)
  end

  private

  def message_params
    params.require(:message).permit(:text, :destroy_option, :count_times)
  end

  def key_params
    params.require(:message_key).permit(:key)
  end
end
