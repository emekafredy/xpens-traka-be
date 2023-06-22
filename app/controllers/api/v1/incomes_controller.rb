class Api::V1::IncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_income, only: %i[show update destroy]

  def index
    @incomes = current_user.incomes

    render_serialized_response(IncomeSerializer, @incomes)
  end

  def create
    income = current_user.incomes.build(income_params)
    income.currency = current_user.currency
    
    if income.save
      render_serialized_response(IncomeSerializer, income)
    else
      bad_request_error(income)
    end
  end

  def show
    render_serialized_response(IncomeSerializer, @income)
  end

  def update
    if @income.update(income_params)
      render_serialized_response(IncomeSerializer, @income)
    else
      bad_request_error(@income)
    end
  end

  def destroy
    if @income.destroy
      render_success_without_data('Income successfully deleted')
    else
      bad_request_error(@income)
    end
  end

  private

  def income_params
    params.require(:income).permit(:amount, :date, :receipt_document, :category_id)
  end

  def set_income
    @income = Income.find_by(id: params[:id])

    return record_not_found('Income') if @income.nil?
  end
end
