# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Incomes', type: :request do
  before do
    create_user
    create_category
  end

  describe 'GET /incomes' do
    before do
      create_list(:income, 4, category: @category, user: @user)
    end

    context 'without authorization' do
      it 'returns an auth error' do
        get api_v1_incomes_path

        expect(response).to have_http_status(:unauthorized)

        res_body = JSON.parse(response.body)
        expect(res_body['status']['message']).to eq 'You are not authorized to perform this action.'
      end
    end

    context 'with authorization' do
      it 'returns all incomes for user' do
        get api_v1_incomes_path, headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)

        res_data = JSON.parse(response.body)['data']
        expect(res_data.count).to eq(4)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid params' do
      it 'creates new income' do
        params = {
          income: {
            amount: 500.00,
            date: Time.zone.now,
            category_id: @category.id
          }
        }

        post api_v1_incomes_path,
             params: params,
             headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)

        data = JSON.parse(response.body)['data']
        expect(data['attributes']['amount']).to eq '500.0'
      end
    end

    context 'with invalid params' do
      it 'throws an error' do
        params = {
          income: {
            amount: 500.00,
            category_id: @category.id
          }
        }

        post api_v1_incomes_path,
             params: params,
             headers: authenticate_user(@user)

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)

        expect(data['status']['code']).to eq 400
        expect(data['status']['message']).to eq "Error: Date can't be blank"
      end
    end
  end

  describe 'GET /show' do
    let(:income) { create(:income, category: @category, user: @user) }

    it 'returns selected income' do
      get api_v1_income_path(income),
          headers: authenticate_user(@user)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    let(:income) { create(:income, category: @category, user: @user) }

    context 'with valid params' do
      it 'updates existing income' do
        params = {
          income: {
            amount: 5000.00
          }
        }

        patch api_v1_income_path(income),
              params: params,
              headers: authenticate_user(@user)

        expect(response).to have_http_status(:success)

        data = JSON.parse(response.body)['data']
        expect(data['attributes']['amount']).to eq '5000.0'
      end
    end

    context 'with invalid params' do
      it 'throws an error' do
        params = {
          income: {
            amount: 0
          }
        }

        patch api_v1_income_path(income),
              params: params,
              headers: authenticate_user(@user)

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)

        expect(data['status']['code']).to eq 400
        expect(data['status']['message']).to eq 'Error: Amount must be greater than 0'
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:income) { create(:income, category: @category, user: @user) }

    it 'deletes selected income' do
      delete api_v1_income_path(income),
             headers: authenticate_user(@user)

      expect(response).to have_http_status(:success)
    end

    context 'when income is already deleted' do
      let(:income2) { create(:income, category: @category, user: @user) }

      before { income2.destroy }

      it 'throws an error' do
        delete api_v1_income_path(income2),
               headers: authenticate_user(@user)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
