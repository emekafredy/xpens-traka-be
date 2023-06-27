# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Expenses', type: :request do
  before do
    create_user
    create_category
  end

  describe 'GET /expenses' do
    before do
      create_list(:expense, 4, category: @category, user: @user)
    end

    context 'without authorization' do
      it 'returns an auth error' do
        get api_v1_expenses_path

        expect(response).to have_http_status(:unauthorized)

        res_body = JSON.parse(response.body)
        expect(res_body['status']['message']).to eq 'You are not authorized to perform this action.'
      end
    end

    context 'with authorization' do
      it 'returns all expenses for user' do
        get api_v1_expenses_path, headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)

        res_data = JSON.parse(response.body)['data']
        expect(res_data.count).to eq(4)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid params' do
      it 'creates new expense' do
        params = {
          expense: {
            amount: -500.00,
            date: Time.zone.now,
            category_id: @category.id
          }
        }

        post api_v1_expenses_path,
             params: params,
             headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)

        data = JSON.parse(response.body)['data']
        expect(data['attributes']['amount']).to eq '-500.0'
      end
    end

    context 'with invalid params' do
      it 'throws an error' do
        params = {
          expense: {
            amount: 500.00,
            date: Time.zone.now,
            category_id: @category.id
          }
        }

        post api_v1_expenses_path,
             params: params,
             headers: authenticate_user(@user)

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)

        expect(data['status']['code']).to eq 400
        expect(data['status']['message']).to eq 'Error: Amount must be less than 0'
      end
    end
  end

  describe 'GET /show' do
    let(:expense) { create(:expense, category: @category, user: @user) }

    it 'returns selected expense' do
      get api_v1_expense_path(expense),
          headers: authenticate_user(@user)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    let(:expense) { create(:expense, category: @category, user: @user) }

    context 'with valid params' do
      it 'updates existing expense' do
        params = {
          expense: {
            amount: -5000.00
          }
        }

        patch api_v1_expense_path(expense),
              params: params,
              headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)

        data = JSON.parse(response.body)['data']
        expect(data['attributes']['amount']).to eq '-5000.0'
      end
    end

    context 'with invalid params' do
      it 'throws an error' do
        params = {
          expense: {
            amount: 5000.0
          }
        }

        patch api_v1_expense_path(expense),
              params: params,
              headers: authenticate_user(@user)

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)

        expect(data['status']['code']).to eq 400
        expect(data['status']['message']).to eq 'Error: Amount must be less than 0'
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:expense) { create(:expense, category: @category, user: @user) }

    it 'deletes selected expense' do
      delete api_v1_expense_path(expense),
             headers: authenticate_user(@user)

      expect(response).to have_http_status(:success)
    end

    context 'when expense is already deleted' do
      let(:expense2) { create(:expense, category: @category, user: @user) }

      before { expense2.destroy }

      it 'throws an error' do
        delete api_v1_expense_path(expense2),
               headers: authenticate_user(@user)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
