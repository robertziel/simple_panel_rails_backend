require 'spec_helper'

describe UsersAPI do
  let(:headers) { {} }
  let(:params) { {} }

  let!(:user) { create(:user) }

  describe '#INDEX' do
    subject do
      get '/api/users', params: params, headers: headers
    end

    include_context :should_check_valid_authentication_token

    include_context :should_have_pagination, :user

    it 'must get index' do
      subject

      expect(response.status).to eq 200

      json = response_body_to_json
      expect(json[:users]).to eq [user.slice(:email, :id, :username).symbolize_keys]
    end
  end

  describe '#SHOW' do
    subject do
      get "/api/users/#{user.id}", headers: headers
    end

    include_context :should_check_valid_authentication_token

    it 'must show user' do
      subject

      expect(response.status).to eq 200

      json = response_body_to_json
      expect(json).to eq user.slice(:email, :id, :username).symbolize_keys
    end
  end
end
