# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_transaction, only: %i[show update destroy]

      def index
        @transactions = current_user.transactions
                                    .where(transaction_type: params[:query])
                                    .order(created_at: :desc)

        render_with_pagination(TransactionSerializer, @transactions, params[:page] || 1, 10)
      end

      def create
        transaction = current_user.transactions.build(transaction_params)
        transaction.currency = current_user.currency

        if transaction.save
          render_serialized_response(TransactionSerializer, transaction)
        else
          bad_request_error(transaction)
        end
      end

      def show
        render_serialized_response(TransactionSerializer, @transaction)
      end

      def update
        if @transaction.update(transaction_params)
          render_serialized_response(TransactionSerializer, @transaction)
        else
          bad_request_error(@transaction)
        end
      end

      def destroy
        if @transaction.destroy
          render_success_without_data('Transaction successfully deleted')
        else
          bad_request_error(@transaction)
        end
      end

      private

      def transaction_params
        params.require(:transaction).permit(:amount, :date, :transaction_type, :receipt_document, :category_id)
      end

      def set_transaction
        @transaction = Transaction.find_by(id: params[:id])

        return record_not_found('Transaction') if @transaction.nil?
      end
    end
  end
end
