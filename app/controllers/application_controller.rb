class ApplicationController < ActionController::API
  include ResponseHelper

  def authenticate_user!
    not_authorized unless signed_in?
  end

  def signed_in?
    current_user.present?
  end
end
