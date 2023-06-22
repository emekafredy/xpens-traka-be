class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    categories = Category.where(section: params[:section], user_id: [current_user.id, nil])

    render_serialized_response(CategorySerializer, categories)
  end

  def create
    category = Category.find_by(name: category_params[:name], user_id: [current_user.id, nil])

    if category.nil?
      category = current_user.categories.build(category_params)

      if category.save
        render_serialized_response(CategorySerializer, category)
      else
        bad_request_error(category)
      end
    else
      render_serialized_response(CategorySerializer, category)
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :section)
  end
end
