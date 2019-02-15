class MessageEncryptorService
  def initialize(message)
    @message = message
  end

  def encrypt
    key = AES.key
    iv = AES.iv(:base_64)
    encrypted_message = AES.encrypt(message, key, { iv: iv })
    { key: key, encrypted_message: encrypted_message }
  end

  private

  attr_reader :message
end
