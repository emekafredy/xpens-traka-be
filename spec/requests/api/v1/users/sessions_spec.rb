# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users::SessionsController', type: :request do
  before { create_user }

  describe 'POST /login' do
    context 'with valid params' do
      it 'registers new user' do
        params = {
          email: @user.email,
          password: 'pass123'
        }

        post api_v1_users_login_path,
             params: params

        expect(response).to have_http_status(:success)

        data = JSON.parse(response.body)['data']
        expect(data['attributes']['username']).to eq 'john.doe'
      end
    end

    context 'with invalid params' do
      it 'throws an error' do
        params = {
          email: @user.email,
          password: 'pass12'
        }

        post api_v1_users_login_path,
             params: params

        expect(response).to have_http_status(:unauthorized)
        data = JSON.parse(response.body)

        expect(data['status']['code']).to eq 401
        expect(data['status']['message']).to eq 'Email or Password is incorrect. Please try again.'
      end
    end
  end

  describe 'GET /api_v1_users_my_account' do
    it 'returns user information' do
      get api_v1_users_my_account_path,
          headers: authenticate_user(@user)

      expect(response).to have_http_status(:success)

      data = JSON.parse(response.body)['data']
      expect(data['attributes']['username']).to eq 'john.doe'
    end
  end
end
