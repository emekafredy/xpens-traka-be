# frozen_string_literal: true

module Api
  module V1
    class BudgetsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_budget, only: %i[show update destroy]

      def index
        @budgets = current_user.budgets
        render_serialized_response(BudgetSerializer, @budgets)
      end

      def create
        budget = current_user.budgets.build(budget_params)
        budget.currency = current_user.currency

        if budget.save
          render_serialized_response(BudgetSerializer, budget)
        else
          bad_request_error(budget)
        end
      end

      def show
        render_serialized_response(BudgetSerializer, @budget)
      end

      def update
        if @budget.update(budget_params)
          render_serialized_response(BudgetSerializer, @budget)
        else
          bad_request_error(@budget)
        end
      end

      def destroy
        if @budget.destroy
          render_success_without_data('Budget successfully deleted')
        else
          bad_request_error(@budget)
        end
      end

      private

      def budget_params
        params.require(:budget).permit(:start_date, :end_date, :income_est, :expense_est)
      end

      def set_budget
        @budget = Budget.find_by(id: params[:id])

        return record_not_found('Budget') if @budget.nil?
      end
    end
  end
end
