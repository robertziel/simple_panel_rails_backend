require 'spec_helper'

describe CurrentUserAPI do
  let!(:user) { create(:user) }

  describe 'GET current_user' do
    let(:headers) { {} }

    subject do
      get '/api/current_user', headers: headers
    end

    include_context :should_check_valid_authentication_token

    it 'should be success' do
      subject

      expect(response.status).to eq 200

      json = response_body_to_json
      expect(json[:username]).not_to be_nil
    end
  end
end
