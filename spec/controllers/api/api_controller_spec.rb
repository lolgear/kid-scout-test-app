require 'spec_helper'

describe Api::ApiController, type: :controller do
  describe 'verification' do
    context '#authenticate' do
      it 'expect to validate requests' do
        expect(controller.authenticate).to be true
      end
    end

    context '#verify_api_token' do
      it 'expect to validate token correctly' do
        expect(controller.verify_api_token).to be true
      end
    end
  end
end
