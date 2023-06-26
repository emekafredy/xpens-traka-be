require 'rails_helper'

RSpec.describe 'Api::V1::Users::RegistrationsController', type: :request do
  describe 'POST /signup' do
    context 'with valid params' do
      it 'registers new user' do
        params = {
          email: 'test@example.com',
          password: 'test123',
          username: 'tester'
        }

        post api_v1_users_signup_path,
             params: params

        expect(response).to have_http_status(:success)

        data = JSON.parse(response.body)['data']

        expect(data["attributes"]["email"]).to eq 'test@example.com'
        expect(data["attributes"]["username"]).to eq 'tester'
      end
    end

    context 'with invalid params' do
      it 'throws an error' do
        params = {
          email: 'test@example.com',
          password: 'test',
          username: 'tester'
        }

        post api_v1_users_signup_path,
             params: params

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)

        expect(data["status"]["code"]).to eq 400
        expect(data["status"]["message"]).to eq "Error: Password is too short (minimum is 6 characters)"
      end
    end
  end
end
