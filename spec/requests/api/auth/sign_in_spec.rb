require 'spec_helper'

describe API::Auth::SignIn do
  let!(:user) { create(:user) }

  describe 'POST sign_in' do
    let(:sign_in_attrs) do
      { email: user.email, password: user.password }
    end

    subject do
      post '/api/auth/sign_in', params: sign_in_attrs
    end

    context 'succeeded' do
      it 'should be success' do
        subject
        expect(response.status).to eq 200
      end

      it 'should return authentication token' do
        subject
        json = response.body.to_json
        expect(json['authentication_token']).not_to be_nil
      end
    end

    context 'did not succeeded' do
      before do
        sign_in_attrs[:password] = 'wrong_password'
      end

      it 'should be unauthorized' do
        subject
        expect(response.status).to eq 401
      end

      it 'should return error message' do
        subject
        json = response.body.to_json
        expect(json['error_message']).not_to be_nil
      end
    end
  end
end
