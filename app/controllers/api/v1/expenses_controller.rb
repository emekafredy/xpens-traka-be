# frozen_string_literal: true

module Api
  module V1
    class ExpensesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_expense, only: %i[show update destroy]

      def index
        @expenses = current_user.expenses
        render_serialized_response(ExpenseSerializer, @expenses)
      end

      def create
        expense = current_user.expenses.build(expense_params)
        expense.currency = current_user.currency

        if expense.save
          render_serialized_response(ExpenseSerializer, expense)
        else
          bad_request_error(expense)
        end
      end

      def show
        render_serialized_response(ExpenseSerializer, @expense)
      end

      def update
        if @expense.update(expense_params)
          render_serialized_response(ExpenseSerializer, @expense)
        else
          bad_request_error(@expense)
        end
      end

      def destroy
        if @expense.destroy
          render_success_without_data('Expense successfully deleted')
        else
          bad_request_error(@expense)
        end
      end

      private

      def expense_params
        params.require(:expense).permit(:amount, :date, :receipt_document, :category_id)
      end

      def set_expense
        @expense = Expense.find_by(id: params[:id])

        return record_not_found('Expense') if @expense.nil?
      end
    end
  end
end
