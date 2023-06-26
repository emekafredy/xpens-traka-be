# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Categories', type: :request do
  before { create_user }

  describe 'GET /index' do
    before do
      create_list(:category, 5)
      create_list(:category, 5, user: @user)
      create_list(:category, 3, section: 'Expense')
      create_list(:category, 4, user: @user, section: 'Expense')
    end

    context 'without authorization' do
      it 'returns all income categories for user' do
        get api_v1_categories_path, params: { section: 'Income' }

        expect(response).to have_http_status(:unauthorized)
        res_body = JSON.parse(response.body)
        expect(res_body['status']['message']).to eq 'You are not authorized to perform this action.'
      end
    end

    context 'with section param as Income' do
      it 'returns all income categories for user' do
        get api_v1_categories_path, params: { section: 'Income' },
                                    headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)
        data = JSON.parse(response.body)['data']
        expect(data.count).to eq(10)
      end
    end

    context 'with no section param as Expense' do
      it 'returns all expense categories for user' do
        get api_v1_categories_path, params: { section: 'Expense' },
                                    headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)
        data = JSON.parse(response.body)['data']
        expect(data.count).to eq(7)
      end
    end

    context 'when user has no personal Income categories' do
      let(:user) { create(:user) }

      it 'returns only default income categories for user' do
        get api_v1_categories_path,
            params: { section: 'Income' },
            headers: authenticate_user(user)

        expect(response).to have_http_status(:success)
        data = JSON.parse(response.body)['data']
        expect(data.count).to eq(5)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid params' do
      it 'creates new category' do
        params = {
          category: {
            name: 'Salary',
            section: 'Income'
          }
        }

        post api_v1_categories_path,
             params: params,
             headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)
        data = JSON.parse(response.body)['data']

        expect(data['attributes']['name']).to eq 'Salary'
      end
    end

    context 'with invalid params' do
      it 'throws an error' do
        params = {
          category: {
            name: 'Salary'
          }
        }

        post api_v1_categories_path,
             params: params,
             headers: authenticate_user(@user)

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)

        expect(data['status']['code']).to eq 400
        expect(data['status']['message']).to eq "Error: Section can't be blank"
      end
    end

    context 'when category already exists for user' do
      it 'does not create a new category but returns the existing one' do
        create(:category, name: 'Salary', section: 'Income')
        params = {
          category: {
            name: 'Salary',
            section: 'Income'
          }
        }

        action = post api_v1_categories_path,
                      params: params,
                      headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)
        expect { action }.not_to change(Category, :count)

        data = JSON.parse(response.body)['data']
        expect(data['attributes']['name']).to eq 'Salary'
      end
    end
  end
end
