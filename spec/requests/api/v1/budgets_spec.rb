# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Budgets', type: :request do
  before do
    create_user
    create_budget
  end

  describe 'GET /budgets' do
    context 'without authorization' do
      it 'returns an auth error' do
        get api_v1_budgets_path

        expect(response).to have_http_status(:unauthorized)

        res_body = JSON.parse(response.body)
        expect(res_body['status']['message']).to eq 'You are not authorized to perform this action.'
      end
    end

    context 'with authorization' do
      it 'returns all budgets for user' do
        get api_v1_budgets_path, headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)

        res_data = JSON.parse(response.body)['data']
        expect(res_data.count).to eq(1)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid params' do
      it 'creates new budget' do
        params = {
          budget: {
            income_est: 500.00,
            expense_est: 1500.00,
            start_date: 30.days.from_now,
            end_date: 60.days.from_now
          }
        }

        post api_v1_budgets_path,
             params: params,
             headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)

        data = JSON.parse(response.body)['data']
        expect(data['attributes']['incomeEst']).to eq '500.0'
      end
    end

    context 'with invalid params' do
      it 'throws an error' do
        params = {
          budget: {
            income_est: 500,
            expense_est: 0,
            start_date: 90.days.from_now
          }
        }

        post api_v1_budgets_path,
             params: params,
             headers: authenticate_user(@user)

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)

        expect(data['status']['code']).to eq 400
        expect(data['status']['message']).to eq "Error: End date can't be blank and Expense est must be greater than 0"
      end
    end

    context 'when date overlaps with existing user budget' do
      before do
        create(:budget, start_date: 5.days.from_now, end_date: 15.days.from_now, user: @user)
      end

      it 'throws an error' do
        params = {
          budget: {
            income_est: 50_000,
            expense_est: 5000,
            start_date: 6.days.from_now,
            end_date: 20.days.from_now
          }
        }

        post api_v1_budgets_path,
             params: params,
             headers: authenticate_user(@user)

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)

        expect(data['status']['code']).to eq 400
        expect(data['status']['message'])
          .to eq 'Error: Start date or End date of this budget overlaps with another created budget.'
      end
    end
  end

  describe 'GET /show' do
    it 'returns selected budget' do
      get api_v1_budget_path(@budget),
          headers: authenticate_user(@user)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    context 'with valid params' do
      it 'updates existing budget' do
        params = {
          budget: {
            income_est: 5000.00
          }
        }

        patch api_v1_budget_path(@budget),
              params: params,
              headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)

        data = JSON.parse(response.body)['data']
        expect(data['attributes']['incomeEst']).to eq '5000.0'
      end
    end

    context 'with invalid params' do
      it 'throws an error' do
        params = {
          budget: {
            income_est: 0.0
          }
        }

        patch api_v1_budget_path(@budget),
              params: params,
              headers: authenticate_user(@user)

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)

        expect(data['status']['code']).to eq 400
        expect(data['status']['message']).to eq 'Error: Income est must be greater than 0'
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes selected budget' do
      delete api_v1_budget_path(@budget),
             headers: authenticate_user(@user)

      expect(response).to have_http_status(:success)
    end

    context 'when budget is already deleted' do
      before { @budget.destroy }

      it 'throws an error' do
        delete api_v1_budget_path(@budget),
               headers: authenticate_user(@user)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
