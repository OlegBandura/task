require 'rails_helper'

RSpec.describe MessageEncryptorService do
  describe '#encrypt' do
    subject { MessageEncryptorService.new('hello').encrypt }

    it 'encrypt message' do
      is_expected.to be_truthy
      is_expected.to have_key(:key)
      is_expected.to have_key(:encrypted_message)
      expect(subject[:key]).not_to be_nil
      expect(subject[:encrypted_message]).not_to be_nil
    end
  end

  describe '#decrypt' do
    subject { MessageEncryptorService.new(message).decrypt(key) }

    let(:message) { 'aWcdtawL2bG1vPqrFyEitw==$rocdg2i9X7RbF7vr4H30Ag==' }
    let(:key) { 'eb3bd495d32398e1f267e757aabc1c3e' }

    it 'decrypt message' do
      is_expected.to be_truthy
      is_expected.to eq 'hello'
    end
  end
end
