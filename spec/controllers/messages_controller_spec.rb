require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe '#show' do
    let!(:message) { { id: 1, text_message: 'hello' }.to_json }

    it 'get message' do
      allow(Net::HTTP).to receive(:get).and_return(message)

      get :show, format: 'application/json', params: { id: 1 }
      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    let!(:message) { { text: 'hello' } }
    it 'create message' do
      allow(Net::HTTP).to receive(:get).and_return(message)

      post :create, format: 'application/json', params: { message: {
        encryption_key: 123,
        destroy_option: 'hour',
        count_times: 1,
        urlsafe: SecureRandom.urlsafe_base64,
        text: 'hello'
        }
      }
      expect(response.status).to eq 200
    end
  end
end
